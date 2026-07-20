execute if score @s dragon_flight_timer matches 0 run summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],ExplosionRadius:3,CustomName:'"Ender Dragon"'}
execute unless score @s dragon_flight_timer matches 0 run summon minecraft:creeper ~ ~ ~ {Fuse:0,attributes:[{base:0.001,id:"minecraft:scale"}],ExplosionRadius:4,CustomName:'"Ender Dragon"'}

execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:5,vertical:0,other_angle:5,particle_type:"minecraft:end_rod",speed:0.0000000009,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:64,vertical:0,other_angle:7,particle_type:"minecraft:end_rod",speed:0.0000000012,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:10,vertical:0,other_angle:10,particle_type:"minecraft:end_rod",speed:0.0000000016,force:"force"}

execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:5,vertical:1,other_angle:5,particle_type:"minecraft:end_rod",speed:0.0000000009,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:64,vertical:1,other_angle:7,particle_type:"minecraft:end_rod",speed:0.0000000012,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:10,vertical:1,other_angle:10,particle_type:"minecraft:end_rod",speed:0.0000000016,force:"force"}

execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:5,vertical:1,other_angle:90,particle_type:"minecraft:end_rod",speed:0.0000000009,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:64,vertical:1,other_angle:90,particle_type:"minecraft:end_rod",speed:0.0000000012,force:"force"}
execute positioned ~ ~0.4 ~ summon minecraft:marker run function roguecraft:particles/ring/init {start_angle:0,total_steps:10,vertical:1,other_angle:90,particle_type:"minecraft:end_rod",speed:0.0000000016,force:"force"}

playsound minecraft:block.conduit.deactivate master @a ~ ~ ~ 2 1