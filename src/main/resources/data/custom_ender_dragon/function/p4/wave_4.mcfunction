bossbar set minecraft:phase_4_mobs name {"text":"Wave 4"}

scoreboard players set #roguecraft_master.ender_dragon dragon_phase 10

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 2

execute in minecraft:the_end positioned 0 73 0 as @a[distance=..1000] run summon minecraft:warden ~ ~ ~ {Tags:["phase_4_mob"],Brain:{memories:{"minecraft:dig_cooldown":{value:{},ttl:1200L}}},Health:250f,PersistenceRequired:true}

execute as @e[tag=phase_4_mob,type=#roguecraft:difficulty/difficulty_impacted] run function roguecraft:difficulty/apply_difficulty with storage roguecraft:master
execute store result bossbar minecraft:phase_4_mobs max run execute if entity @e[tag=phase_4_mob]
effect give @e[type=minecraft:warden,tag=phase_4_mob] minecraft:weakness infinite 2 true

execute in minecraft:the_end as @e[y=0,tag=phase_4_mob] run function custom_ender_dragon:check_spreadplayers {distance:5}