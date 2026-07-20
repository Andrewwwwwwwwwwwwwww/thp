execute if entity @s[tag=z] run execute at @s run tp ~ ~ ~-2
execute if entity @s[tag=x] run execute at @s run tp ~-2 ~ ~
execute if entity @s[tag=xzp] run execute at @s run tp ~-2 ~ ~-2
execute if entity @s[tag=xzm] run execute at @s run tp ~-2 ~ ~2

summon minecraft:area_effect_cloud ~ ~ ~ {Duration:120,Tags:["tntsoon"],custom_particle:{type:"minecraft:block",block_state:"minecraft:air"}}
playsound minecraft:ui.toast.in master @a ~ ~ ~ 1 2