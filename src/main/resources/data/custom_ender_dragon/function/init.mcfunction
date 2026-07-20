scoreboard players set #roguecraft_master.ender_dragon dragon_phase 0
scoreboard players set #roguecraft_master.ender_dragon dragon_rng 0
scoreboard players set #roguecraft_master.ender_dragon dragon_p1t_health 0
scoreboard players set #roguecraft_master.ender_dragon dragon_health 1000

execute in minecraft:the_end positioned 0 100 0 at @e[type=minecraft:end_crystal,distance=..200] run summon minecraft:marker ~ ~ ~ {Tags:["end_crystal_marker"]}

schedule clear custom_ender_dragon:init

schedule function custom_ender_dragon:quarter_second_tick 2s
schedule function custom_ender_dragon:two_second_tick 2s