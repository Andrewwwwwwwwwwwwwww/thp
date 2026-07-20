# THP: vanilla-style revival. Count End Crystals ringing the lit exit portal; 4+ respawns the dragon.
scoreboard players set #thp thp_count 0
execute in minecraft:the_end positioned 0 70 0 as @e[type=minecraft:end_crystal,distance=..6] run scoreboard players add #thp thp_count 1
execute if score #thp thp_count matches 4.. run function roguecraft:ender_dragon/revive
