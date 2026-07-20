execute unless entity @s[tag=split_1] unless entity @s[tag=split_2] unless entity @s[tag=split_3] run return fail


execute if entity @s[tag=split_1] run particle minecraft:dust{color:[0.73,0.0,1.0],scale:3.0} ~ ~ ~ 0.5 0.5 0.5 0.01 5 force
execute if entity @s[tag=split_2] run particle minecraft:dust{color:[0.73,0.0,1.0],scale:3.0} ~ ~ ~ 0.5 0.5 0.5 0.01 3 force
execute if entity @s[tag=split_3] run particle minecraft:dust{color:[0.73,0.0,1.0],scale:3.0} ~ ~ ~ 0.5 0.5 0.5 0.01 1 force

execute unless data entity @s {OnGround:1b} run return 0

execute if entity @s[tag=split_1] run summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],Invulnerable:true,CustomName:'"Ender Dragon"',ExplosionRadius:4}
execute if entity @s[tag=split_2] run summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],Invulnerable:true,CustomName:'"Ender Dragon"',ExplosionRadius:2}
execute if entity @s[tag=split_3] run summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],Invulnerable:true,CustomName:'"Ender Dragon"',ExplosionRadius:1}
execute if entity @s run fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:cave_air replace end_stone
execute if entity @s run fill ~ ~-2 ~ ~ ~-2 ~ minecraft:amethyst_block replace end_stone
execute if entity @s[tag=split_3] run return run kill @s

execute if entity @s[tag=split_1] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[0.0,1.5,-1.0],Tags:["split_2"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_1] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[0.0,1.5,1.0],Tags:["split_2"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_1] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[-1.0,1.5,0.0],Tags:["split_2"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_1] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[1.0,1.5,0.0],Tags:["split_2"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_1] run return run kill @s

execute if entity @s[tag=split_2] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[0.5,1.5,0.5],Tags:["split_3"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_2] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[0.5,1.5,-0.5],Tags:["split_3"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_2] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[-0.5,1.5,0.5],Tags:["split_3"],Invulnerable:true,Invisible:1b,Small:1b}
execute if entity @s[tag=split_2] run summon minecraft:armor_stand ~ ~0.5 ~ {Motion:[-0.5,1.5,-0.5],Tags:["split_3"],Invulnerable:true,Invisible:1b,Small:1b}
kill @s