# THP: begin (or restart, via revive) the custom dragon encounter. The arena already exists.
# The dragon itself is summoned by roguecraft:three_second once it sees end:1 + dragon_health 1000
# + no dragon present.

# Keep the arena loaded for the duration of the fight (attacks & the summon check reach out ~140 blocks).
execute in minecraft:the_end run forceload add -100 -100 100 100

# Fight is now active.
data modify storage roguecraft:master end set value 1

# Bossbar (plain literal name).
bossbar set minecraft:dragon name "Ender Dragon"
bossbar set minecraft:dragon max 600
bossbar set minecraft:dragon color purple
bossbar set minecraft:dragon players @a[nbt={Dimension:"minecraft:the_end"}]

# Phase markers, scoreboards/timers, and the aerial phase.
function custom_ender_dragon:p1t/marker_summon
function custom_ender_dragon:init
function custom_ender_dragon:p1t/p2_start

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~
