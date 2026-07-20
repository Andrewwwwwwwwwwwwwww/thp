#init
execute if entity @e[type=minecraft:ender_dragon,tag=cdragon] unless score #roguecraft_master.ender_dragon dragon_phase matches -100.. run schedule function custom_ender_dragon:init 1s append
bossbar set minecraft:phase_4_mobs players @a[nbt={Dimension:"minecraft:the_end"}]

#check if roguecraft_master.ender_dragon exists
execute unless score #roguecraft_master.ender_dragon dragon_health matches -1000.. run return 0

#dragon_phase 0
execute if score #roguecraft_master.ender_dragon dragon_phase matches 0 run data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Ender Dragon"'
execute if entity @e[type=minecraft:ender_dragon,tag=cdragon] store result score #roguecraft_master.ender_dragon dragon_health run data get entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] Health
execute store result bossbar minecraft:dragon value run data get entity @e[type=minecraft:ender_dragon,tag=cdragon,limit=1] Health
#execute if score #roguecraft_master.ender_dragon dragon_phase matches 0 if score #roguecraft_master.ender_dragon dragon_health matches ..100 run scoreboard players set #roguecraft_master.ender_dragon dragon_phase 1

#dragon_phase 1/2
execute if score #roguecraft_master.ender_dragon dragon_phase matches 1..2 run data modify entity @e[type=minecraft:ender_dragon,limit=1] DragonPhase set value 5
execute if score #roguecraft_master.ender_dragon dragon_phase matches 1..2 run kill @e[type=minecraft:dragon_fireball]
execute if score #roguecraft_master.ender_dragon dragon_phase matches 1..2 in minecraft:the_end positioned 0 100 0 run kill @e[type=minecraft:area_effect_cloud,distance=..300]
execute if score #roguecraft_master.ender_dragon dragon_phase matches 2 run scoreboard players add #roguecraft_master.ender_dragon dragon_p1t_health 5
execute if score #roguecraft_master.ender_dragon dragon_phase matches 2 run execute at @e[type=minecraft:marker,tag=end_crystal_marker] run particle minecraft:dust{color:[0.73,0.0,1.0],scale:4.0} ~ ~ ~ 2 30 2 1 1 force

#dragon_phase 3
execute if score #roguecraft_master.ender_dragon dragon_phase matches 3 if score #roguecraft_master.ender_dragon dragon_health matches ..420 run function custom_ender_dragon:p2t/main
execute if score #roguecraft_master.ender_dragon dragon_phase matches 3 if score #roguecraft_master.ender_dragon dragon_health matches ..420 run scoreboard players set #roguecraft_master.ender_dragon dragon_phase 4

#dragon_phase 4
execute if score #roguecraft_master.ender_dragon dragon_phase matches 4 run data modify entity @e[type=minecraft:ender_dragon,limit=1] DragonPhase set value 5

#dragon_phase 5
execute if score #roguecraft_master.ender_dragon dragon_phase matches 5 if score #roguecraft_master.ender_dragon dragon_health matches ..240 run function custom_ender_dragon:p3t/main
execute if score #roguecraft_master.ender_dragon dragon_phase matches 5 if score #roguecraft_master.ender_dragon dragon_health matches ..240 run scoreboard players set #roguecraft_master.ender_dragon dragon_phase 6

#dragon_phase 6/7/8/9/10/11
execute if score #roguecraft_master.ender_dragon dragon_phase matches 6..11 in minecraft:the_end positioned 0 100 0 run kill @e[type=minecraft:area_effect_cloud,distance=..300]
execute if score #roguecraft_master.ender_dragon dragon_phase matches 6..11 run data modify entity @e[type=minecraft:ender_dragon,limit=1] DragonPhase set value 5
execute as @e[type=minecraft:marker,tag=nether_star_clear] at @s unless entity @e[type=minecraft:wither,tag=phase_4_mob] run function custom_ender_dragon:p4/clear_nether_star
execute in minecraft:the_end unless entity @e[tag=phase_4_mob,y=0] run function custom_ender_dragon:p4/change_wave

#dragon_phase 12
execute if score #roguecraft_master.ender_dragon dragon_phase matches 12 if score #roguecraft_master.ender_dragon dragon_health matches ..150 run function custom_ender_dragon:p5/subphase_2

#dragon_phase 13
execute if score #roguecraft_master.ender_dragon dragon_phase matches 13 if score #roguecraft_master.ender_dragon dragon_health matches ..60 run function custom_ender_dragon:p5/subphase_3

#dragon_phase 14
execute if score #roguecraft_master.ender_dragon dragon_phase matches 14 if score #roguecraft_master.ender_dragon dragon_health matches ..0 run function custom_ender_dragon:p5/end



#phase 4
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:marker,tag=summon_portal,distance=..320] at @s run function custom_ender_dragon:p4/tick_portal
execute as @e[tag=phase_4_mob] run data modify entity @s Glowing set value 1b
execute store result bossbar minecraft:phase_4_mobs value run execute if entity @e[tag=phase_4_mob]

#attacks p2#

#meteor
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:armor_stand,tag=Meteor,distance=..320] at @s run function custom_ender_dragon:p2/meteor/tick

#tnt lines
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:area_effect_cloud,tag=tnt,distance=..320] at @s run function custom_ender_dragon:p2/tnt/tick
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:area_effect_cloud,tag=tntsoon,distance=..192] at @s run function custom_ender_dragon:p2/tnt/tick_line

#lightning ring
execute as @e[type=minecraft:area_effect_cloud,tag=lightning_ring] run execute at @s run tp @s ^ ^ ^0.17 ~0.5 ~
execute at @e[type=minecraft:area_effect_cloud,tag=lightning_ring] positioned over motion_blocking run particle minecraft:dust{color:[0.73,0.0,1.0],scale:1.5} ~ ~ ~ 0 0 0 1 1

#lightning endermen
execute if entity @e[type=minecraft:marker,tag=dragon_endermen] in minecraft:the_end as @e[type=minecraft:enderman] at @s run particle minecraft:electric_spark ~ ~1.5 ~ 0 0 0 0.1 2

#balls
execute as @e[type=minecraft:dragon_fireball,tag=balls] at @s positioned ~ 0 ~ if entity @s[distance=200..] run function custom_ender_dragon:p2/balls/main_2


#attacks p3

#missile
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:area_effect_cloud,tag=auto_aim,distance=..320] at @s run function custom_ender_dragon:p3/missile/tick

#split
execute in minecraft:the_end positioned 0 63 0 as @e[type=minecraft:armor_stand,distance=..320] at @s run function custom_ender_dragon:p3/split/tick

#generate end
execute in minecraft:the_end positioned 0 63 0 at @p as @n[type=minecraft:marker,tag=end_gen_marker,distance=..256] at @s if loaded ~ ~ ~ run function custom_ender_dragon:generate/generate_end with entity @s data

#fucking murder that bird
execute in minecraft:the_end positioned 0 63 0 if entity @a[distance=..1000] as @e[type=minecraft:ender_dragon,limit=1] if score #roguecraft_master.ender_dragon dragon_health matches ..2 run function custom_ender_dragon:instakill

#end tp
execute in minecraft:the_end as @a[y=0] at @s positioned 0 ~ 0 if entity @s[distance=110..] at @s unless block ~ ~-1 ~ air run function custom_ender_dragon:check_spreadplayers {distance:5}

#fixes
kill @e[type=minecraft:ender_dragon,tag=!cdragon]
execute as @e[tag=phase_4_mob,tag=!post_tag] at @s run function custom_ender_dragon:p4/dirt_fix