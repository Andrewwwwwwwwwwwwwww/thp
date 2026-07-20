forceload remove ~ ~

execute in minecraft:the_end run tp @e[type=#roguecraft:post_enderdragon_removed,dx=16,dy=256,dz=16] 0 0 0
execute in minecraft:the_end run tp @e[type=minecraft:interaction,dx=16,dy=256,dz=16] 0 0 0
execute in minecraft:the_end run tp @e[type=minecraft:end_crystal,dx=16,dy=256,dz=16] 0 0 0

execute in minecraft:the_end positioned 0 0 0 run kill @e[distance=..1]

fillbiome ~ ~ ~ ~16 ~255 ~16 minecraft:the_end
execute positioned ~8 0 ~8 run kill @e[type=minecraft:interaction,distance=..4]
$execute store success storage roguecraft:master success byte 1 run place template custom_ender_dragon:island_$(phase)/$(coordinate)

execute unless data entity @s {data:{phase:2}} if data storage roguecraft:master {success:1b} as @a[dx=16,dy=256,dz=16] at @s run tp ~ 70 ~
execute if data storage roguecraft:master {success:1b} run kill @s