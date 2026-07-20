#if end foundtain has not generated
execute in minecraft:the_end unless block 0 72 0 minecraft:bedrock run return run schedule function custom_ender_dragon:generate/first_enter 1t

#if it gets to this point, the ender dragon has died and the fountain has loaded
data modify storage roguecraft:master end_generation.first_entered set value 1b

#place end gen markers at center and tick them
function custom_ender_dragon:generate/replace_portal

execute in minecraft:the_end positioned 0 0 0 as @e[type=minecraft:marker,tag=end_gen_marker,tag=priority,distance=..256] at @s run function custom_ender_dragon:generate/generate_end with entity @s data

#remove gateway
execute in minecraft:the_end positioned 96 75 0 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 91 75 29 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 77 75 56 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 56 75 77 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 29 75 91 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 0 75 96 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -29 75 91 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -56 75 77 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -77 75 56 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -91 75 29 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -96 75 0 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -91 75 -29 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -77 75 -56 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -56 75 -77 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned -29 75 -91 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 0 75 -96 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 29 75 -91 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 56 75 -77 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 77 75 -56 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}
execute in minecraft:the_end positioned 91 75 -29 run summon minecraft:marker ~ ~ ~ {Tags:["end_gateway_remover"]}