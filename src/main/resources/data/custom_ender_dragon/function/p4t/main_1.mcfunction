scoreboard players set #roguecraft_master.ender_dragon dragon_phase 12

execute in minecraft:the_end positioned 0 62 0 as @a[distance=..300] run function roguecraft:bosses/progress_skillpoints {skillpoints:5,string:"roguecraft.boss_progress.ender_dragon_wave"}

kill @e[type=minecraft:marker,tag=summon_portal]
particle minecraft:reverse_portal ~ ~ ~ 0 0 0 3 2000 force

execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.beacon.deactivate hostile @s ~ ~ ~
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:entity.ender_dragon.growl hostile @s ~ ~ ~

bossbar remove minecraft:phase_4_mobs

schedule function custom_ender_dragon:p4t/main_2 5s append