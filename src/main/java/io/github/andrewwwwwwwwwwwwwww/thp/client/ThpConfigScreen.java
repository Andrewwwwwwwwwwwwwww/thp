package io.github.andrewwwwwwwwwwwwwww.thp.client;

import io.github.andrewwwwwwwwwwwwwww.thp.PortalActivation;
import net.minecraft.ChatFormatting;
import net.minecraft.client.Minecraft;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.components.EditBox;
import net.minecraft.client.gui.components.StringWidget;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;
import net.minecraft.server.MinecraftServer;

public class ThpConfigScreen extends Screen {
    private final Screen parent;
    private final boolean remoteServer;
    private EditBox playersField;

    public ThpConfigScreen(Screen parent) {
        super(Component.translatable("thp.config.title"));
        this.parent = parent;
        this.remoteServer = Minecraft.getInstance().getCurrentServer() != null;
    }

    @Override
    protected void init() {
        int cx = this.width / 2;

        addRenderableWidget(new StringWidget(0, 18, this.width, 12, this.title, this.font));

        if (remoteServer) {
            addRenderableWidget(new StringWidget(0, 60, this.width, 12,
                Component.translatable("thp.config.remote")
                    .withStyle(ChatFormatting.GRAY), this.font));
            addRenderableWidget(new StringWidget(0, 80, this.width, 12,
                Component.translatable("thp.config.commands_hint")
                    .withStyle(ChatFormatting.GRAY), this.font));
            addRenderableWidget(new StringWidget(0, 104, this.width, 12,
                Component.literal("/thp portalreq")
                    .withStyle(ChatFormatting.AQUA), this.font));
            addRenderableWidget(new StringWidget(0, 120, this.width, 12,
                Component.literal("/thp setendplayercount <n>")
                    .withStyle(ChatFormatting.AQUA), this.font));

            addRenderableWidget(Button.builder(
                Component.translatable("gui.back"),
                btn -> this.minecraft.setScreenAndShow(parent)
            ).bounds(cx - 50, this.height - 30, 100, 20).build());
            return;
        }

        addRenderableWidget(new StringWidget(0, 65, this.width, 12,
            Component.translatable("thp.config.players_label"), this.font));

        this.playersField = new EditBox(this.font, cx - 60, 85, 120, 20, Component.translatable("thp.config.players"));
        this.playersField.setMaxLength(3);
        this.playersField.setValue(String.valueOf(PortalActivation.getRequiredPlayersValue()));
        addRenderableWidget(this.playersField);

        addRenderableWidget(Button.builder(
            Component.translatable("thp.config.save"),
            btn -> {
                try {
                    int v = Math.max(1, Integer.parseInt(this.playersField.getValue()));
                    PortalActivation.setRequiredPlayers(v);
                    MinecraftServer s = this.minecraft.getSingleplayerServer();
                    if (s != null) PortalActivation.save(s);
                } catch (NumberFormatException ignored) {}
                this.minecraft.setScreenAndShow(parent);
            }
        ).bounds(cx - 105, this.height - 30, 100, 20).build());

        addRenderableWidget(Button.builder(
            Component.translatable("gui.cancel"),
            btn -> this.minecraft.setScreenAndShow(parent)
        ).bounds(cx + 5, this.height - 30, 100, 20).build());
    }

    @Override
    public void onClose() {
        this.minecraft.setScreenAndShow(parent);
    }
}
