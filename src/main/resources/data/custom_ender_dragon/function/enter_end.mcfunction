tag @s add end
function custom_ender_dragon:check_spreadplayers {distance:5}
effect give @s minecraft:blindness 2 0 true
effect give @s minecraft:darkness 2 0 true
effect give @s minecraft:resistance 10 4 true
clear @s minecraft:end_portal_frame

title @s subtitle {"text":"Slayer of the ancient beast, prove yourself","color":"light_purple"}
title @s title {"text":"The Ender Dragon","color":"light_purple"}