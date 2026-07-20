data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Magnificent Ultra Extraordinary Fantabulous Mega Hyper Jean"'
scoreboard players set #roguecraft_master.ender_dragon dragon_phase 13

execute in minecraft:the_end positioned 0 62 0 as @a[distance=..300] run function roguecraft:bosses/progress_skillpoints {skillpoints:5,string:"roguecraft.boss_progress.ender_dragon"}

schedule clear custom_ender_dragon:p5/attack_timer_15s
schedule function custom_ender_dragon:p5/attack_timer_10s 10s
execute at @e[type=minecraft:ender_dragon] run summon minecraft:lightning_bolt
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.deactivate hostile @s ~ ~ ~
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~