# THP: first entry into the End after the ritual. Build the custom arena from scratch,
# then hand off to gen_watch which starts the fight once generation finishes.

# Mark "generating" so the tick driver neither re-fires begin nor runs the fight yet.
data modify storage roguecraft:master end set value 2

# Hold every player high above the arena, blind, while it builds — hides the generation and keeps
# them off the vanilla spawn platform (which gets overwritten). gen_watch keeps them here; arena_ready
# drops them onto the finished arena.
effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:blindness 30 0 true
effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:darkness 30 0 true
effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:resistance 30 4 true
effect give @a[nbt={Dimension:"minecraft:the_end"}] minecraft:slow_falling 30 0 true
execute in minecraft:the_end run fill -1 199 -1 1 199 1 minecraft:barrier
# MUST be End-scoped: tick/scheduled functions execute in the OVERWORLD, and a bare tp moves
# targets to the execution dimension — an unscoped tp here yanks players OUT of the End.
execute in minecraft:the_end run tp @a[nbt={Dimension:"minecraft:the_end"}] 0 200 0

# Clear any vanilla dragon-fight remnants (the vanilla fight is also suppressed in Java,
# but scrub anything already spawned so it can't interfere).
execute in minecraft:the_end run kill @e[type=minecraft:ender_dragon]
execute in minecraft:the_end positioned 0 64 0 run kill @e[type=minecraft:end_crystal,distance=..256]

# Forceload the FULL build area: the arena grid is ±112, and the surrounding ring of vanilla
# island fringe is wiped out to ±140 by clear_end (air templates), so load ±144.
execute in minecraft:the_end run forceload add -144 -144 144 144

# Wait for the chunks, then wipe the fringe + build the arena (prep_watch polls).
schedule function roguecraft:ender_dragon/prep_watch 10t
