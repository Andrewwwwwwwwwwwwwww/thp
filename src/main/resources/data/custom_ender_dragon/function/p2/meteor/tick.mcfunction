execute positioned over motion_blocking run particle minecraft:portal ~ ~ ~ 0 0 0 0.1 5 force
particle minecraft:dust{color:[0.73,0.0,1.0],scale:3.0} ~ ~ ~ 0.5 0.5 0.5 0.01 5 force

execute unless data entity @s {OnGround:1b} run return 0

summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],Invulnerable:true,CustomName:'"Ender Dragon"',ExplosionRadius:4}
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:cave_air replace end_stone
fill ~ ~-2 ~ ~ ~-2 ~ minecraft:amethyst_block replace end_stone
kill