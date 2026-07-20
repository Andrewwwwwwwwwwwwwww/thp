data modify storage roguecraft:master end_generation.init set value 1b
data modify storage roguecraft:master end_generation.visited set value 0b

execute in minecraft:the_end run forceload add -112 -112 112 112
function custom_ender_dragon:generate/set_end_markers

schedule function custom_ender_dragon:generate/check_loaded 1s
#data modify storage roguecraft:master end_generated set value 1b