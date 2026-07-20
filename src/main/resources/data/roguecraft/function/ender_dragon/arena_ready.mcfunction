# THP: arena is built — release the held players onto it, then start the fight.

# Release the held players: remove the holding platform, clear the long blindness, and set them down
# on the finished arena at centre.
execute in minecraft:the_end run fill -1 199 -1 1 199 1 minecraft:air
effect clear @a[nbt={Dimension:"minecraft:the_end"}] minecraft:blindness
effect clear @a[nbt={Dimension:"minecraft:the_end"}] minecraft:darkness
effect clear @a[nbt={Dimension:"minecraft:the_end"}] minecraft:slow_falling
execute as @a[nbt={Dimension:"minecraft:the_end"}] run function custom_ender_dragon:check_spreadplayers {distance:5}

# Drop the wide build-area forceload; start_fight re-adds the ±100 fight area.
execute in minecraft:the_end run forceload remove -144 -144 144 144

function roguecraft:ender_dragon/start_fight
