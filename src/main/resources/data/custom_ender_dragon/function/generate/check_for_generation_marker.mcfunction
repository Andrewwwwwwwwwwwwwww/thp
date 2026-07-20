execute in minecraft:the_end unless entity @e[tag=end_gen_marker] run fill 98 48 2 99 48 -2 minecraft:air
execute in minecraft:the_end unless entity @e[tag=end_gen_marker] if loaded 112 100 112 if loaded -112 100 112 if loaded 112 100 -112 if loaded -112 100 -112 run return run forceload remove -112 -112 112 112

execute in minecraft:the_end positioned 0 0 0 as @n[y=0,type=minecraft:marker,tag=end_gen_marker] at @s run function custom_ender_dragon:generate/generate_end with entity @s data
schedule function custom_ender_dragon:generate/check_for_generation_marker 1t