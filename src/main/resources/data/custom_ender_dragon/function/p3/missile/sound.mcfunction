#this happens 10 times before the explosion

#for pitching the sound up later
scoreboard players add @s count 1

#base sound
execute if score @s count matches ..7 run playsound minecraft:block.beacon.activate master @a ~ ~ ~ 5 0.5
execute if score @s count matches 8 run playsound minecraft:block.beacon.activate master @a ~ ~ ~ 5 0.54
execute if score @s count matches 9 run playsound minecraft:block.beacon.activate master @a ~ ~ ~ 5 0.58
execute if score @s count matches 10 run playsound minecraft:block.beacon.activate master @a ~ ~ ~ 5 0.62