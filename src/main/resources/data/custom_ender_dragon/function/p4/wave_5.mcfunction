bossbar set minecraft:phase_4_mobs name {"text":"Wave 5"}
bossbar set minecraft:phase_4_mobs max 8

scoreboard players set #roguecraft_master.ender_dragon dragon_phase 11

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 2

summon minecraft:marker ~ ~ ~ {Tags:["nether_star_clear"]}

summon minecraft:wither ~ ~ ~ {Tags:["phase_4_mob"]}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:wither_skeleton ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:stone_sword"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:wither_skeleton ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:stone_sword"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:wither_skeleton ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:stone_sword"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:wither_skeleton ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:stone_sword"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:wither_skeleton ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:stone_sword"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}

execute as @e[tag=phase_4_mob,type=#roguecraft:difficulty/difficulty_impacted] run function roguecraft:difficulty/apply_difficulty with storage roguecraft:master
execute store result bossbar minecraft:phase_4_mobs max run execute if entity @e[tag=phase_4_mob]

execute in minecraft:the_end as @e[y=0,tag=phase_4_mob] run function custom_ender_dragon:check_spreadplayers {distance:5}