execute in minecraft:the_end run tp @e[type=minecraft:ender_dragon,tag=dragon_p1] 0 150 0
data modify entity @e[type=minecraft:ender_dragon,tag=dragon_p1,limit=1] DragonPhase set value 5
tag @e[type=minecraft:ender_dragon,tag=dragon_p1] remove dragon_p1
execute in minecraft:the_end run summon minecraft:lightning_bolt 0 150 0
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.deactivate hostile @s ~ ~ ~
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~
data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Jean"'
attribute @e[type=minecraft:ender_dragon,limit=1] minecraft:max_health base set 1000
execute at @e[type=minecraft:ender_dragon] run particle minecraft:explosion_emitter ~ ~ ~ 0.25 0.25 0.25 1 1 force
execute at @e[type=minecraft:ender_dragon] run particle minecraft:explosion_emitter ~ ~ ~ 0.25 0.25 0.25 1 1 force
execute at @e[type=minecraft:ender_dragon] run particle minecraft:explosion_emitter ~ ~ ~ 0.25 0.25 0.25 1 1 force
scoreboard players set #roguecraft_master.ender_dragon dragon_phase 2