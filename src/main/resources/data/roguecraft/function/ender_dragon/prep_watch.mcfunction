# THP: wait for the ±144 build area to load, then wipe the vanilla island fringe and start
# the arena generator. Forceloaded chunks load async, so poll until the far corners are in.
execute unless score #thp portal_activated matches 1 run return 0
execute unless data storage roguecraft:master {end:2} run return 0

execute in minecraft:the_end unless loaded -140 0 -140 run return run schedule function roguecraft:ender_dragon/prep_watch 10t
execute in minecraft:the_end unless loaded 140 0 -140 run return run schedule function roguecraft:ender_dragon/prep_watch 10t
execute in minecraft:the_end unless loaded -140 0 140 run return run schedule function roguecraft:ender_dragon/prep_watch 10t
execute in minecraft:the_end unless loaded 140 0 140 run return run schedule function roguecraft:ender_dragon/prep_watch 10t

# Wipe the ring of vanilla island around the arena footprint (±100..±140) with air templates,
# THEN generate the arena — the grid rebuilds the rim cells the ring overlaps.
function custom_ender_dragon:clear_end
data modify storage roguecraft:master end_generation.visited set value 1b
function custom_ender_dragon:generate/generate_init

# Poll for generation completion.
schedule function roguecraft:ender_dragon/gen_watch 40t
