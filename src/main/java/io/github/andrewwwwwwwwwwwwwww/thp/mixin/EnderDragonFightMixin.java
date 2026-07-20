package io.github.andrewwwwwwwwwwwwwww.thp.mixin;

import net.minecraft.world.level.dimension.end.EnderDragonFight;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

/**
 * Suppresses vanilla's Ender Dragon fight entirely. The Hungering Portal replaces the End
 * encounter with its own custom, datapack-driven fight and arena, so the vanilla fight must
 * not run alongside it — otherwise vanilla spawns its own dragon, obsidian pillars and caged
 * crystals, and (on kill) an exit portal + gateway, all of which conflict with the custom fight.
 *
 * Cancelling {@link EnderDragonFight#tick()} stops the vanilla fight from ever spawning a dragon,
 * pillars, crystals, or the exit portal. THP builds its own exit portal + gateways when the
 * custom dragon dies. Players can only reach the End after completing the portal ritual, so
 * suppressing the vanilla fight unconditionally is safe.
 */
@Mixin(EnderDragonFight.class)
public class EnderDragonFightMixin {

    @Inject(method = "tick", at = @At("HEAD"), cancellable = true)
    private void thp$suppressVanillaFight(CallbackInfo ci) {
        ci.cancel();
    }
}
