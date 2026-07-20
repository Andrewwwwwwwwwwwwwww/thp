# THP: wait until the arena generator has consumed every placement marker, then start the fight.
# Abort if the fight was reset/disarmed mid-generation.
execute unless score #thp portal_activated matches 1 run return 0
execute unless data storage roguecraft:master {end:2} run return 0

# Still generating? Keep players held above the arena (topped up so the effects never lapse) and wait.
execute if entity @e[type=minecraft:marker,tag=end_gen_marker] run effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:blindness 10 0 true
execute if entity @e[type=minecraft:marker,tag=end_gen_marker] run effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:darkness 10 0 true
execute if entity @e[type=minecraft:marker,tag=end_gen_marker] run effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:slow_falling 10 0 true
execute if entity @e[type=minecraft:marker,tag=end_gen_marker] in minecraft:the_end run tp @a[nbt={Dimension:"minecraft:the_end"}] 0 200 0
execute if entity @e[type=minecraft:marker,tag=end_gen_marker] run return run schedule function roguecraft:ender_dragon/gen_watch 20t

# Generation done — start the fight.
function roguecraft:ender_dragon/arena_ready
