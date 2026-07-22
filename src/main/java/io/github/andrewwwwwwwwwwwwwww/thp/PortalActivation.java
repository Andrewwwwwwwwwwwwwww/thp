package io.github.andrewwwwwwwwwwwwwww.thp;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.github.andrewwwwwwwwwwwwwww.thp.text.Lang;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import net.minecraft.ChatFormatting;
import net.minecraft.core.BlockPos;
import net.minecraft.network.chat.Component;
import net.minecraft.network.protocol.game.ClientboundSetSubtitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitlesAnimationPacket;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.item.ItemEntity;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.storage.LevelResource;
import net.minecraft.world.phys.AABB;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

public class PortalActivation {
    private static final Logger LOGGER = LoggerFactory.getLogger("The Hungering Portal");
    private static final com.google.gson.Gson GSON = new GsonBuilder().setPrettyPrinting().create();
    private static final long TIMEOUT_TICKS = 20L * 60L;
    private static final double NEARBY_RADIUS = 16.0;

    private static final Map<Item, String> ITEM_TO_ID = new LinkedHashMap<>();
    private static final Map<String, Item> ID_TO_ITEM = new HashMap<>();
    /** How many of each offering must be thrown in. Absent = 1. */
    private static final Map<Item, Integer> REQUIRED_COUNT = new HashMap<>();
    static {
        ITEM_TO_ID.put(Items.TRIDENT, "trident");
        ITEM_TO_ID.put(Items.NETHERITE_BLOCK, "netherite_block");
        ITEM_TO_ID.put(Items.SNIFFER_EGG, "sniffer_egg");
        ITEM_TO_ID.put(Items.ENCHANTED_GOLDEN_APPLE, "enchanted_golden_apple");
        ITEM_TO_ID.put(Items.TOTEM_OF_UNDYING, "totem_of_undying");
        ITEM_TO_ID.put(Items.BEACON, "beacon");
        ITEM_TO_ID.put(Items.MACE, "mace");
        ITEM_TO_ID.put(Items.WITHER_ROSE, "wither_rose");
        ITEM_TO_ID.put(Items.CONDUIT, "conduit");
        ITEM_TO_ID.put(Items.ZOMBIE_HEAD, "zombie_head");
        for (Map.Entry<Item, String> e : ITEM_TO_ID.entrySet()) {
            ID_TO_ITEM.put(e.getValue(), e.getKey());
        }
        REQUIRED_COUNT.put(Items.WITHER_ROSE, 16);
    }

    public static final Set<Item> REQUIRED_ITEMS = ITEM_TO_ID.keySet();

    private static int requiredCount(Item item) {
        return REQUIRED_COUNT.getOrDefault(item, 1);
    }

    private static boolean activated = false;
    private static final Set<Item> consumed = new LinkedHashSet<>();
    /** Progress toward each offering's required count (for multi-count offerings like Wither Roses). */
    private static final Map<Item, Integer> consumedCount = new LinkedHashMap<>();
    private static final Map<Item, UUID> consumedBy = new LinkedHashMap<>();
    private static final Set<UUID> participants = new LinkedHashSet<>();
    private static long lastConsumeTick = 0L;
    private static BlockPos lastPortalPos = null;
    private static int requiredPlayers = 3;

    private static final Map<UUID, Long> lastMessageTick = new HashMap<>();
    private static final List<PendingChat> pendingChats = new ArrayList<>();
    private static final List<PendingTitle> pendingTitles = new ArrayList<>();
    private static Path savePath = null;

    private record PendingChat(UUID playerId, List<Component> messages, long fireTick, boolean broadcast) {}
    private record PendingTitle(UUID playerId, Component title, Component subtitle, int fadeIn, int stay, int fadeOut, long fireTick) {}

    public static void setRequiredPlayers(int count) {
        requiredPlayers = Math.max(1, count);
    }

    public static int getRequiredPlayersValue() {
        return Math.max(1, requiredPlayers);
    }

    public static boolean isActivated(ServerLevel level) {
        return activated;
    }

    public static void load(MinecraftServer server) {
        Lang.setServer(server);
        savePath = server.getWorldPath(LevelResource.ROOT).resolve("endbeast.json");
        activated = false;
        consumed.clear();
        consumedCount.clear();
        consumedBy.clear();
        participants.clear();
        lastConsumeTick = 0L;
        lastPortalPos = null;
        requiredPlayers = 3;
        lastMessageTick.clear();
        pendingChats.clear();
        pendingTitles.clear();
        if (!Files.exists(savePath)) {
            setFightArmed(server, activated);
            return;
        }
        try {
            JsonObject json = JsonParser.parseString(Files.readString(savePath)).getAsJsonObject();
            if (json.has("activated")) activated = json.get("activated").getAsBoolean();
            if (json.has("consumed")) {
                JsonArray list = json.getAsJsonArray("consumed");
                for (JsonElement e : list) {
                    Item item = ID_TO_ITEM.get(e.getAsString());
                    if (item != null) consumed.add(item);
                }
            }
            if (json.has("consumedCount")) {
                JsonObject counts = json.getAsJsonObject("consumedCount");
                for (Map.Entry<String, JsonElement> e : counts.entrySet()) {
                    Item item = ID_TO_ITEM.get(e.getKey());
                    if (item != null) consumedCount.put(item, e.getValue().getAsInt());
                }
            }
            if (json.has("consumedBy")) {
                JsonObject byMap = json.getAsJsonObject("consumedBy");
                for (Map.Entry<String, JsonElement> e : byMap.entrySet()) {
                    Item item = ID_TO_ITEM.get(e.getKey());
                    if (item != null) {
                        try {
                            consumedBy.put(item, UUID.fromString(e.getValue().getAsString()));
                        } catch (IllegalArgumentException ignored) { }
                    }
                }
            }
            if (json.has("participants")) {
                JsonArray list = json.getAsJsonArray("participants");
                for (JsonElement e : list) {
                    try {
                        participants.add(UUID.fromString(e.getAsString()));
                    } catch (IllegalArgumentException ignored) { }
                }
            }
            if (json.has("lastConsumeTick")) lastConsumeTick = json.get("lastConsumeTick").getAsLong();
            if (json.has("lastPortalPos")) {
                JsonObject pos = json.getAsJsonObject("lastPortalPos");
                lastPortalPos = new BlockPos(
                    pos.get("x").getAsInt(),
                    pos.get("y").getAsInt(),
                    pos.get("z").getAsInt()
                );
            }
            if (json.has("requiredPlayers")) requiredPlayers = Math.max(1, json.get("requiredPlayers").getAsInt());
        } catch (Exception e) {
            LOGGER.error("Failed to load state", e);
        }
        setFightArmed(server, activated);
    }

    /**
     * Bridges the ritual state into the bundled End-fight datapack: the custom Ender Dragon fight
     * only starts once {@code #thp portal_activated} is 1. Mirrors {@link #activated}. The objective
     * is created by the datapack's {@code roguecraft:setup} (minecraft:load), which runs before this.
     */
    private static void setFightArmed(MinecraftServer server, boolean armed) {
        if (server == null) return;
        try {
            server.getCommands().performPrefixedCommand(
                server.createCommandSourceStack().withSuppressedOutput(),
                "scoreboard players set #thp portal_activated " + (armed ? 1 : 0));
        } catch (Exception e) {
            LOGGER.error("Failed to sync End-fight armed state", e);
        }
    }

    public static void save(MinecraftServer server) {
        if (savePath == null) return;
        try {
            JsonObject json = new JsonObject();
            json.addProperty("activated", activated);

            JsonArray list = new JsonArray();
            for (Item item : consumed) {
                String id = ITEM_TO_ID.get(item);
                if (id != null) list.add(id);
            }
            json.add("consumed", list);

            JsonObject counts = new JsonObject();
            for (Map.Entry<Item, Integer> e : consumedCount.entrySet()) {
                String id = ITEM_TO_ID.get(e.getKey());
                if (id != null) counts.addProperty(id, e.getValue());
            }
            json.add("consumedCount", counts);

            JsonObject byMap = new JsonObject();
            for (Map.Entry<Item, UUID> e : consumedBy.entrySet()) {
                String id = ITEM_TO_ID.get(e.getKey());
                if (id != null) byMap.addProperty(id, e.getValue().toString());
            }
            json.add("consumedBy", byMap);

            JsonArray pList = new JsonArray();
            for (UUID id : participants) pList.add(id.toString());
            json.add("participants", pList);

            json.addProperty("lastConsumeTick", lastConsumeTick);
            if (lastPortalPos != null) {
                JsonObject pos = new JsonObject();
                pos.addProperty("x", lastPortalPos.getX());
                pos.addProperty("y", lastPortalPos.getY());
                pos.addProperty("z", lastPortalPos.getZ());
                json.add("lastPortalPos", pos);
            }
            json.addProperty("requiredPlayers", requiredPlayers);

            Files.createDirectories(savePath.getParent());
            Files.writeString(savePath, GSON.toJson(json));
        } catch (Exception e) {
            LOGGER.error("Failed to save state", e);
        }
    }

    public static boolean tryConsume(ServerLevel level, ItemEntity itemEntity) {
        if (activated) return false;
        ItemStack stack = itemEntity.getItem();
        Item item = stack.getItem();
        if (!REQUIRED_ITEMS.contains(item)) return false;
        if (consumed.contains(item)) return false; // this offering is already fully satisfied

        int reqCount = requiredCount(item);
        int have = consumedCount.getOrDefault(item, 0);
        int stillNeeded = reqCount - have;
        if (stillNeeded <= 0) return false;

        int take = Math.min(stack.getCount(), stillNeeded);
        consumedCount.put(item, have + take);

        UUID throwerId = null;
        Entity owner = itemEntity.getOwner();
        if (owner != null) throwerId = owner.getUUID();

        if (throwerId != null) {
            consumedBy.put(item, throwerId);
            participants.add(throwerId);
        }
        lastConsumeTick = level.getGameTime();
        lastPortalPos = itemEntity.blockPosition();

        addNearbyParticipants(level);

        // Take only what the offering needs; leave any surplus floating in the portal.
        if (stack.getCount() > take) {
            stack.shrink(take);
            itemEntity.setItem(stack);
        } else {
            itemEntity.discard();
        }

        if (have + take >= reqCount) {
            consumed.add(item); // offering complete
        }

        int required = getRequiredPlayers();
        if (consumed.containsAll(REQUIRED_ITEMS) && participants.size() >= required) {
            activate(level);
        } else if (consumed.containsAll(REQUIRED_ITEMS) && throwerId != null) {
            ServerPlayer p = level.getServer().getPlayerList().getPlayer(throwerId);
            if (p != null) {
                int needed = required - participants.size();
                String subKey = needed == 1 ? "thp.offerings_made.sub_one" : "thp.offerings_made.sub_many";
                String chatKey = needed == 1 ? "thp.offerings_made.chat_one" : "thp.offerings_made.chat_many";
                sendTitle(p,
                    styled(Lang.tr(p, "thp.offerings_made.title", "Offerings made"), ChatFormatting.GOLD, ChatFormatting.BOLD),
                    styled(Lang.tr(p, subKey, needed == 1 ? "%d more witness needed" : "%d more witnesses needed", needed),
                            ChatFormatting.GRAY, ChatFormatting.ITALIC),
                    10, 80, 20);
                scheduleChat(p, List.of(styled(Lang.tr(p, chatKey,
                        needed == 1 ? "The offerings are made, but %d more witness needed." : "The offerings are made, but %d more witnesses needed.",
                        needed), ChatFormatting.GRAY, ChatFormatting.ITALIC)), 110);
            }
        }
        save(level.getServer());
        return true;
    }

    public static void tick(MinecraftServer server) {
        ServerLevel level = server.overworld();
        if (level == null) return;

        long gameTime = level.getGameTime();

        if (!pendingTitles.isEmpty()) {
            Iterator<PendingTitle> tit = pendingTitles.iterator();
            while (tit.hasNext()) {
                PendingTitle pt = tit.next();
                if (gameTime >= pt.fireTick()) {
                    ServerPlayer p = server.getPlayerList().getPlayer(pt.playerId());
                    if (p != null) {
                        sendTitle(p, pt.title(), pt.subtitle(), pt.fadeIn(), pt.stay(), pt.fadeOut());
                    }
                    tit.remove();
                }
            }
        }

        if (!pendingChats.isEmpty()) {
            Iterator<PendingChat> it = pendingChats.iterator();
            while (it.hasNext()) {
                PendingChat pc = it.next();
                if (gameTime >= pc.fireTick()) {
                    deliverChat(server, pc);
                    it.remove();
                }
            }
        }

        if (activated) return;
        if (consumed.isEmpty()) return;

        if (level.getGameTime() - lastConsumeTick > TIMEOUT_TICKS) {
            returnItems(server, level);
            return;
        }

        if (lastPortalPos != null && level.getGameTime() % 20L == 0L) {
            int beforeSize = participants.size();
            addNearbyParticipants(level);
            if (participants.size() > beforeSize) {
                int required = getRequiredPlayers();
                if (consumed.containsAll(REQUIRED_ITEMS) && participants.size() >= required) {
                    activate(level);
                }
                save(server);
            }
        }
    }

    private static void addNearbyParticipants(ServerLevel level) {
        if (lastPortalPos == null) return;
        AABB area = new AABB(lastPortalPos).inflate(NEARBY_RADIUS);
        for (ServerPlayer p : level.getEntitiesOfClass(ServerPlayer.class, area)) {
            participants.add(p.getUUID());
        }
    }

    private static int getRequiredPlayers() {
        return Math.max(1, requiredPlayers);
    }

    private static void activate(ServerLevel level) {
        activated = true;
        consumed.clear();
        participants.clear();
        consumedBy.clear();
        lastMessageTick.clear();
        pendingTitles.clear();
        lastPortalPos = null;
        setFightArmed(level.getServer(), true);
        broadcastActivation(level);
    }

    /**
     * Re-locks the End Portal: clears activation and all in-progress ritual state, so the portal
     * once again requires the full ritual to open. Any offerings mid-ritual are NOT returned.
     */
    public static void reset(MinecraftServer server) {
        activated = false;
        consumed.clear();
        consumedCount.clear();
        consumedBy.clear();
        participants.clear();
        lastConsumeTick = 0L;
        lastPortalPos = null;
        lastMessageTick.clear();
        pendingTitles.clear();
        pendingChats.clear();
        setFightArmed(server, false);
        save(server);

        for (ServerPlayer p : server.getPlayerList().getPlayers()) {
            sendTitle(p,
                styled(Lang.tr(p, "thp.reset.title", "The End Portal hungers once more"), ChatFormatting.DARK_RED, ChatFormatting.BOLD),
                styled(Lang.tr(p, "thp.reset.sub", "The way is sealed"), ChatFormatting.GRAY, ChatFormatting.ITALIC),
                20, 120, 40);
        }
    }

    public static void onPlayerDisconnect(UUID uuid) {
        lastMessageTick.remove(uuid);
        pendingChats.removeIf(pc -> !pc.broadcast() && pc.playerId().equals(uuid));
        pendingTitles.removeIf(pt -> pt.playerId().equals(uuid));
    }

    private static void scheduleTitle(ServerPlayer player, Component title, Component subtitle, int fadeIn, int stay, int fadeOut, int delayTicks) {
        long fireTick = player.level().getGameTime() + delayTicks;
        pendingTitles.add(new PendingTitle(player.getUUID(), title, subtitle, fadeIn, stay, fadeOut, fireTick));
    }

    private static void scheduleChat(ServerPlayer player, List<Component> messages, int delayTicks) {
        long fireTick = player.level().getGameTime() + delayTicks;
        pendingChats.add(new PendingChat(player.getUUID(), messages, fireTick, false));
    }

    private static void scheduleBroadcastChat(ServerLevel level, List<Component> messages, int delayTicks) {
        long fireTick = level.getGameTime() + delayTicks;
        pendingChats.add(new PendingChat(null, messages, fireTick, true));
    }

    private static void deliverChat(MinecraftServer server, PendingChat pc) {
        if (pc.broadcast()) {
            for (ServerPlayer p : server.getPlayerList().getPlayers()) {
                for (Component msg : pc.messages()) p.sendSystemMessage(msg);
            }
        } else {
            ServerPlayer p = server.getPlayerList().getPlayer(pc.playerId());
            if (p != null) {
                for (Component msg : pc.messages()) p.sendSystemMessage(msg);
            }
        }
    }

    private static void returnItems(MinecraftServer server, ServerLevel level) {
        Set<UUID> notifiedPlayers = new HashSet<>();
        // Return everything thrown in, including partial progress toward multi-count offerings.
        for (Map.Entry<Item, Integer> e : consumedCount.entrySet()) {
            Item item = e.getKey();
            int remaining = e.getValue();
            UUID throwerId = consumedBy.get(item);
            ServerPlayer player = throwerId != null ? server.getPlayerList().getPlayer(throwerId) : null;
            while (remaining > 0) {
                int n = Math.min(remaining, 64);
                remaining -= n;
                ItemStack stack = new ItemStack(item, n);
                if (player != null) {
                    if (!player.getInventory().add(stack)) {
                        player.drop(stack, false);
                    }
                    notifiedPlayers.add(throwerId);
                } else if (lastPortalPos != null) {
                    ItemEntity drop = new ItemEntity(level,
                        lastPortalPos.getX() + 0.5,
                        lastPortalPos.getY() + 1.0,
                        lastPortalPos.getZ() + 0.5,
                        stack);
                    level.addFreshEntity(drop);
                }
            }
        }

        for (UUID uuid : notifiedPlayers) {
            ServerPlayer p = server.getPlayerList().getPlayer(uuid);
            if (p != null) {
                sendTitle(p,
                    styled(Lang.tr(p, "thp.return.title", "The portal grew impatient"), ChatFormatting.RED, ChatFormatting.BOLD),
                    styled(Lang.tr(p, "thp.return.sub", "Your offerings have been returned"), ChatFormatting.GRAY, ChatFormatting.ITALIC),
                    10, 80, 20);
                scheduleChat(p, List.of(styled(Lang.tr(p, "thp.return.chat",
                        "The portal grew impatient and returned your offerings."), ChatFormatting.GRAY, ChatFormatting.ITALIC)), 110);
            }
        }

        consumed.clear();
        consumedCount.clear();
        consumedBy.clear();
        participants.clear();
        lastConsumeTick = 0L;
        lastPortalPos = null;
        save(server);
    }

    private static void broadcastActivation(ServerLevel level) {
        // Per-player so each online player gets the announcement in their own language.
        for (ServerPlayer p : level.getServer().getPlayerList().getPlayers()) {
            sendTitle(p,
                styled(Lang.tr(p, "thp.open.title", "The End Portal hungers no more"), ChatFormatting.LIGHT_PURPLE, ChatFormatting.BOLD),
                styled(Lang.tr(p, "thp.open.sub", "The way is open"), ChatFormatting.LIGHT_PURPLE),
                20, 140, 40);
            scheduleChat(p, List.of(styled(Lang.tr(p, "thp.open.chat",
                    "The End Portal hungers no more. The way is open."), ChatFormatting.LIGHT_PURPLE, ChatFormatting.BOLD)), 200);
        }
    }

    public static void repelPlayer(ServerPlayer player, BlockPos portalPos) {
        double dx = player.getX() - (portalPos.getX() + 0.5);
        double dz = player.getZ() - (portalPos.getZ() + 0.5);
        double mag = Math.sqrt(dx * dx + dz * dz);
        if (mag < 0.1) {
            double yaw = Math.toRadians(player.getYRot());
            dx = -Math.sin(yaw);
            dz = Math.cos(yaw);
        } else {
            dx /= mag;
            dz /= mag;
        }
        player.setDeltaMovement(dx * 1.2, 0.8, dz * 1.2);
        player.hurtMarked = true;

        long now = player.level().getGameTime();
        Long last = lastMessageTick.get(player.getUUID());
        if (last == null || now - last > 300) {
            showRequirements(player);
            lastMessageTick.put(player.getUUID(), now);
        }
    }

    // The ten offerings, in ritual order. Flavor/name text is translatable per key; colours are fixed.
    private static final String[] REQ_IDS = {
        "trident", "netherite_block", "sniffer_egg", "enchanted_golden_apple", "totem_of_undying",
        "beacon", "mace", "wither_rose", "conduit", "zombie_head"};
    private static final ChatFormatting[] REQ_COLORS = {
        ChatFormatting.AQUA, ChatFormatting.DARK_PURPLE, ChatFormatting.GREEN, ChatFormatting.YELLOW,
        ChatFormatting.WHITE, ChatFormatting.GOLD, ChatFormatting.GRAY, ChatFormatting.DARK_GRAY,
        ChatFormatting.DARK_AQUA, ChatFormatting.DARK_GREEN};
    private static final String[] REQ_FLAVOR_EN = {
        "A Trident from the bubbling undead", "A block of Nether & Gold forged steel",
        "An egg of a beast long past", "An Apple glistening with power", "A hand held savior",
        "A Nether Star's gilded prison", "A mace of crushing weight",
        "Sixteen roses grown from the Wither's wake", "A ward of the drowned deep",
        "and finally a skull from the restless dead"};
    private static final String[] REQ_NAME_EN = {
        "Trident", "Netherite Block", "Sniffer Egg", "Enchanted Golden Apple", "Totem of Undying",
        "Beacon", "Mace", "16 Wither Roses", "Conduit", "Zombie Head"};

    private static Component styled(String text, ChatFormatting... styles) {
        return Component.literal(text).withStyle(styles);
    }

    private static Component[] requirementFlavor(ServerPlayer p) {
        Component[] out = new Component[REQ_IDS.length];
        for (int i = 0; i < REQ_IDS.length; i++) {
            out[i] = styled(Lang.tr(p, "thp.req.flavor." + REQ_IDS[i], REQ_FLAVOR_EN[i]), REQ_COLORS[i]);
        }
        return out;
    }

    private static String requirementName(ServerPlayer p, int i) {
        return Lang.tr(p, "thp.req.name." + REQ_IDS[i], REQ_NAME_EN[i]);
    }

    private static List<Component> requirementChatLines(ServerPlayer p) {
        Component[] items = requirementFlavor(p);
        List<Component> chatLines = new ArrayList<>();
        chatLines.add(styled(Lang.tr(p, "thp.req.heading", "Collect these items few"), ChatFormatting.GOLD, ChatFormatting.BOLD));
        for (int i = 0; i < items.length; i++) {
            chatLines.add(Component.literal("  ").append(items[i])
                .append(styled(" (" + requirementName(p, i) + ")", ChatFormatting.WHITE)));
        }
        int required = getRequiredPlayers();
        chatLines.add(styled(Lang.tr(p, required == 1 ? "thp.req.witnesses_one" : "thp.req.witnesses_many",
                required == 1 ? "%d witness required to activate the portal" : "%d witnesses required to activate the portal",
                required), ChatFormatting.GRAY, ChatFormatting.ITALIC));
        return chatLines;
    }

    /** The requirements in chat only — used by the /thp portalreq command. */
    public static void showRequirementsChat(ServerPlayer player) {
        UUID uuid = player.getUUID();
        pendingChats.removeIf(pc -> !pc.broadcast() && pc.playerId().equals(uuid));
        for (Component line : requirementChatLines(player)) {
            player.sendSystemMessage(line);
        }
    }

    /** On-screen titles then chat — used only when a player jumps into a not-yet-opened portal. */
    public static void showRequirements(ServerPlayer player) {
        UUID uuid = player.getUUID();
        pendingTitles.removeIf(pt -> pt.playerId().equals(uuid));
        pendingChats.removeIf(pc -> !pc.broadcast() && pc.playerId().equals(uuid));

        Component[] items = requirementFlavor(player);
        int t = 0;
        scheduleTitle(player, styled(Lang.tr(player, "thp.req.heading", "Collect these items few"),
                ChatFormatting.GOLD, ChatFormatting.BOLD), Component.empty(), 5, 40, 10, t);
        t += 50;
        int total = items.length;
        for (int i = 0; i < items.length; i++) {
            Component offeringTitle = styled(Lang.tr(player, "thp.req.offering", "Offering %d of %d", i + 1, total),
                    ChatFormatting.GOLD, ChatFormatting.BOLD);
            scheduleTitle(player, offeringTitle, items[i], 5, 30, 5, t);
            t += 35;
        }
        scheduleChat(player, requirementChatLines(player), t);
    }

    private static void sendTitle(ServerPlayer player, Component title, Component subtitle, int fadeIn, int stay, int fadeOut) {
        player.connection.send(new ClientboundSetTitlesAnimationPacket(fadeIn, stay, fadeOut));
        if (subtitle != null) {
            player.connection.send(new ClientboundSetSubtitleTextPacket(subtitle));
        }
        player.connection.send(new ClientboundSetTitleTextPacket(title));
    }
}
