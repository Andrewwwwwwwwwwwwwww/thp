# THP adaptation of RogueCraft's per-tick driver (minecraft:tick tag).
# Gated behind the Hungering Portal ritual and a one-and-done completion flag.

# Do nothing until the portal ritual has been completed.
execute unless score #thp portal_activated matches 1 run return 0

# Arm & start the fight the first time a player is in the End (once only). end:0 means
# "not started"; begin flips it to 2 (generating) then 1 (active), so this won't re-fire.
execute unless data storage roguecraft:master {end_generation:{first_entered:1b}} if data storage roguecraft:master {end:0} if entity @a[nbt={Dimension:"minecraft:the_end"}] in minecraft:the_end if loaded 0 0 0 run function roguecraft:ender_dragon/begin

# After the fight is beaten, placing 4+ End Crystals around the exit portal respawns the dragon.
execute if data storage roguecraft:master {end:0} if data storage roguecraft:master {end_generation:{first_entered:1b}} in minecraft:the_end positioned 0 70 0 if entity @e[type=minecraft:end_crystal,distance=..8] run function roguecraft:ender_dragon/check_revive

# Run the fight while it is active.
execute if data storage roguecraft:master {end:1} run function custom_ender_dragon:tick

# Intro effects for players entering the arena during an active fight only.
execute unless data storage roguecraft:master {end_generation:{first_entered:1b}} if data storage roguecraft:master {end:1} as @a[nbt={Dimension:"minecraft:the_end"},tag=!end] run function custom_ender_dragon:enter_end
