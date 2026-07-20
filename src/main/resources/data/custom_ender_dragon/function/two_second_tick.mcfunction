#remove end gateway
execute in minecraft:the_end positioned 0 75 0 as @e[type=minecraft:marker,tag=end_gateway_remover,distance=..128] at @s run function custom_ender_dragon:generate/remove_gateway

#attacks
execute as @e[type=minecraft:area_effect_cloud,tag=lightning_ring] run execute positioned 0 100 0 run execute if entity @s[distance=8..] run execute at @s positioned over motion_blocking run summon minecraft:lightning_bolt
execute as @e[type=minecraft:area_effect_cloud,tag=auto_aim] at @s run function custom_ender_dragon:p3/missile/sound

#spawn end crystal during final phase
execute store result score #roguecraft_master.ender_dragon dragon_rng run random value 1..30
execute if score #roguecraft_master.ender_dragon dragon_rng matches 1 if score #roguecraft_master.ender_dragon dragon_phase matches 12..14 run execute at @e[type=minecraft:marker,tag=phase_2t,sort=random,limit=1] unless entity @e[type=minecraft:end_crystal,distance=..1] run execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.power_select master @s ~ ~ ~ 0.5 2
execute if score #roguecraft_master.ender_dragon dragon_rng matches 1 if score #roguecraft_master.ender_dragon dragon_phase matches 12..14 run execute at @e[type=minecraft:marker,tag=phase_2t,sort=random,limit=1] unless entity @e[type=minecraft:end_crystal,distance=..1] run summon minecraft:end_crystal ~ ~ ~ {ShowBottom:false,Glowing:true,beam_target:[I;0,73,0]}

#reset flight timer
scoreboard players add @e[type=minecraft:ender_dragon] dragon_flight_timer 1
execute as @e[type=minecraft:ender_dragon,nbt={DragonPhase:3}] run function custom_ender_dragon:reset_flight_timer
execute as @e[type=minecraft:ender_dragon,nbt={DragonPhase:5}] run function custom_ender_dragon:reset_flight_timer
execute as @e[type=minecraft:ender_dragon,nbt={DragonPhase:6}] run function custom_ender_dragon:reset_flight_timer
execute as @e[type=minecraft:ender_dragon,nbt={DragonPhase:7}] run function custom_ender_dragon:reset_flight_timer

execute in minecraft:the_end positioned 0 70 0 if entity @a[distance=..100] as @e[type=minecraft:ender_dragon,scores={dragon_flight_timer=20..},limit=1] unless score #roguecraft_master.ender_dragon dragon_health matches ..2 run data modify entity @s DragonPhase set value 2
execute in minecraft:the_end positioned 0 70 0 if entity @a[distance=..100] as @e[type=minecraft:ender_dragon,scores={dragon_flight_timer=20..},limit=1] unless score #roguecraft_master.ender_dragon dragon_health matches ..2 run data modify entity @s DragonPhase set value 2

schedule function custom_ender_dragon:two_second_tick 40t