execute store result storage roguecraft:master player_count_end byte 1 if entity @a[nbt={Dimension:"minecraft:the_end"}]
execute if data storage roguecraft:master {player_count_end:1b} run return run function custom_ender_dragon:p3/attack_select

#execute if score @r[type=ender_dragon,limit=1] dragon_flight_timer matches 0 run return run function custom_ender_dragon:p3/attack_select
effect give @a[gamemode=!spectator,nbt={Dimension:"minecraft:the_end"}] minecraft:nausea 7 1 true
schedule function custom_ender_dragon:p3/tp/main_2 4s append
execute as @a[gamemode=!spectator,nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:block.portal.travel hostile @s ~ ~ ~ 0.5 1.25