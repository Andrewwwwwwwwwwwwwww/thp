# THP: End-crystal revival — respawn the custom dragon in the existing arena (arena is already built).

# Consume the crystals with an explosion flourish (like vanilla).
execute in minecraft:the_end positioned 0 70 0 at @e[type=minecraft:end_crystal,distance=..6] run particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 force
execute in minecraft:the_end positioned 0 70 0 run kill @e[type=minecraft:end_crystal,distance=..6]

# Extinguish the exit portal for the duration of the fight (finish re-lights it on the next kill).
# The pool fills the basin's carved-air cells, so drain it back to air — the basin's original state.
execute in minecraft:the_end run fill -2 69 -2 2 69 2 minecraft:air replace minecraft:end_portal

# Restart the encounter.
function roguecraft:ender_dragon/start_fight
