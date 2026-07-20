execute as @e[type=minecraft:marker,tag=end_gen_marker,tag=priority] at @s if loaded ~ ~ ~ run function custom_ender_dragon:generate/generate_end with entity @s data

execute in minecraft:the_end positioned 0 0 0 as @e[type=#roguecraft:post_enderdragon_removed,type=!minecraft:marker,distance=..2000,tag=!end_crystal_spawner,tag=!egg_spawner] at @s run tp 0 -100 0
#data modify storage roguecraft:master end_generated set value 2b