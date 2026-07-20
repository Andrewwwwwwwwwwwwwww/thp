bossbar set minecraft:phase_4_mobs name {"text":"Wave 3"}

scoreboard players set #roguecraft_master.ender_dragon dragon_phase 9

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 2

execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:ravager ~ ~ ~ {Tags:["phase_4_mob"],PersistenceRequired:true}
summon minecraft:ravager ~ ~ ~ {Tags:["phase_4_mob"],PersistenceRequired:true}
summon minecraft:illusioner ~ ~ ~ {Tags:["phase_4_mob"],PersistenceRequired:true}

execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:vindicator ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:iron_axe"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:vindicator ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:iron_axe"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:vindicator ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:iron_axe"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:vindicator ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:iron_axe"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}

execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:pillager ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:crossbow"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:pillager ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:crossbow"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:pillager ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:crossbow"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:pillager ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:crossbow"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}
summon minecraft:pillager ~ ~ ~ {Tags:["phase_4_mob"],equipment:{mainhand:{count:1,id:"minecraft:crossbow"}},drop_chances:{mainhand:0.0,offhand:0.0},PersistenceRequired:true}

execute as @e[tag=phase_4_mob,type=#roguecraft:difficulty/difficulty_impacted] run function roguecraft:difficulty/apply_difficulty with storage roguecraft:master
execute store result bossbar minecraft:phase_4_mobs max run execute if entity @e[tag=phase_4_mob]

execute in minecraft:the_end as @e[y=0,tag=phase_4_mob] run function custom_ender_dragon:check_spreadplayers {distance:5}