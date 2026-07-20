execute in minecraft:the_end run summon minecraft:lightning_bolt 0 150 0
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.deactivate hostile @s ~ ~ ~
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~
scoreboard players set #roguecraft_master.ender_dragon dragon_phase 5
data modify entity @e[type=minecraft:ender_dragon,limit=1] DragonPhase set value 1
data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Hyper Jean"'

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.anvil.place master @a ~ ~ ~ 0.4 1.5
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.anvil.land master @a ~ ~ ~ 0.4 1.5

execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}
execute in minecraft:the_end run summon minecraft:shulker 0 100 0 {Color:10,Tags:["dragon_minion"]}

execute as @e[type=minecraft:shulker,tag=dragon_minion] run function custom_ender_dragon:check_spreadplayers {distance:50}

schedule function custom_ender_dragon:p3/attack_timer 5s