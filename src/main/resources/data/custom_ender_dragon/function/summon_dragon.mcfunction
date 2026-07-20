execute in minecraft:the_end run summon minecraft:ender_dragon 0 150 0 {Tags:["cdragon","roguecraft_dragon"]}
scoreboard players set @e[type=minecraft:ender_dragon,tag=cdragon] dragon_flight_timer 0
attribute @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] minecraft:max_health base set 600
data modify entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] Health set value 600f
data modify entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] DragonPhase set value 1