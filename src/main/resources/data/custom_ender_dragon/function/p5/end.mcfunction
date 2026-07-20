schedule clear custom_ender_dragon:p2/attack_timer
schedule clear custom_ender_dragon:p3/attack_timer
schedule clear custom_ender_dragon:p5/attack_timer_5s
schedule clear custom_ender_dragon:p5/attack_timer_10s
schedule clear custom_ender_dragon:p5/attack_timer_15s
#bossbar remove minecraft:custom_dragon
execute in minecraft:the_end positioned 0 100 0 run kill @e[type=minecraft:marker,distance=..300]
function roguecraft:misc/set_gamerule {gamerule:"max_block_modifications",value:"1000000000"}

data modify entity @e[type=minecraft:ender_dragon,limit=1] CustomName set value '"Ender Dragon"'

bossbar set minecraft:dragon players @a[tag=olkjahsoihaef]

kill @e[type=minecraft:armor_stand,tag=split_1]
kill @e[type=minecraft:armor_stand,tag=split_2]
kill @e[type=minecraft:armor_stand,tag=split_3]
kill @e[type=minecraft:armor_stand,tag=Meteor]