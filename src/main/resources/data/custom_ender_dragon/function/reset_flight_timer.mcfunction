scoreboard players set @s dragon_flight_timer 0
execute at @e[type=minecraft:area_effect_cloud,tag=auto_aim] run function custom_ender_dragon:p3/missile/explode
execute as @e[type=minecraft:area_effect_cloud,tag=auto_aim] run kill @s