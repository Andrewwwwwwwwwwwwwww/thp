schedule clear custom_ender_dragon:activate_end
function custom_ender_dragon:generate/replace_portal

tag @e remove cdragon

execute in minecraft:the_end run tp @e[y=0,type=minecraft:ender_dragon,tag=!cdragon] 0 0 0
execute in minecraft:the_end run tp @e[y=0,type=minecraft:area_effect_cloud] 0 0 0
execute in minecraft:the_end run tp @e[y=0,type=minecraft:shulker] 0 0 0
execute in minecraft:the_end run tp @e[y=0,tag=phase_4_mob] 0 0 0
execute in minecraft:the_end run tp @e[y=0,type=minecraft:interaction,tag=egg_interaction] 0 0 0
execute in minecraft:the_end run tp @e[y=0,type=minecraft:block_display,tag=egg_block] 0 0 0
execute in minecraft:the_end run tp @e[y=0,type=minecraft:item_display] 0 0 0

execute in minecraft:the_end positioned 0 0 0 run kill @e[distance=..5]
execute in minecraft:the_end positioned 0 0 0 run kill @e[type=minecraft:marker,tag=!end_gen_marker,distance=..2000]

#function custom_ender_dragon:summon_dragon

data modify storage roguecraft:master end set value 1
data modify storage roguecraft:master end_generation.visited set value 1b
bossbar remove minecraft:phase_4_mobs

function custom_ender_dragon:generate/check_for_generation_marker

#bossbar name ender dragon
bossbar set minecraft:dragon name "Ender Dragon"

#first end enter
execute unless data storage roguecraft:master {end_generation:{first_entered:1b}} run function custom_ender_dragon:generate/first_enter

function custom_ender_dragon:p1t/marker_summon
function custom_ender_dragon:init
function custom_ender_dragon:p1t/p2_start

execute in minecraft:the_end run forceload remove -100 -100 100 100
execute in minecraft:the_end run forceload add 0 0