execute in minecraft:the_end run summon minecraft:lightning_bolt 0 150 0
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.deactivate hostile @s ~ ~ ~
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~
data modify entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] Health set value 1000f
bossbar set minecraft:dragon max 600
scoreboard players set #roguecraft_master.ender_dragon dragon_phase 3
data modify entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] DragonPhase set value 1

schedule function custom_ender_dragon:p2/attack_timer 5s