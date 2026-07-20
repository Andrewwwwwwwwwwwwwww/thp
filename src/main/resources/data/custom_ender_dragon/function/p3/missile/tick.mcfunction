data modify entity @s Motion set value [0.0,0.0,0.0]
execute facing entity @p[gamemode=!spectator] feet run tp ^ ^ ^0.2
particle minecraft:portal ~ ~ ~ 0.5 0.5 0.5 0 10 normal
particle minecraft:portal ~ ~ ~ 0.5 0.5 0.5 0 5 force
particle minecraft:dust{color:[0.73,0.0,1.0],scale:3.0} ~ ~ ~ 0.5 0.5 0.5 0.01 7 force
playsound minecraft:block.conduit.attack.target master @a ~ ~ ~ 0.6 0
particle minecraft:dust{color:[0.73,0.0,1.0],scale:2.0} ~ ~ ~ 5 5 5 0.02 3 normal

#explosion
execute if entity @s[nbt={Age:399}] run function custom_ender_dragon:p3/missile/explode