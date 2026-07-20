execute in minecraft:the_end run tp @e[type=minecraft:ender_dragon] 0 150 0
execute in minecraft:the_end run summon minecraft:lightning_bolt 0 150 0
data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Ultra Extraordinary Fantabulous Mega Hyper Jean"'
data modify entity @e[type=minecraft:ender_dragon,limit=1] DragonPhase set value 1
schedule function custom_ender_dragon:p5/attack_timer_15s 5s append
execute at @e[type=minecraft:marker,tag=end_crystal_marker] run summon minecraft:marker ~ 109 ~ {Tags:["glass_pillar"]}
execute at @e[type=minecraft:marker,tag=end_crystal_marker] run summon minecraft:marker ~ 114 ~ {Tags:["glass_destroyer"]}