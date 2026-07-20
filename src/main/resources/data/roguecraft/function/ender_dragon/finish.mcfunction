# THP adaptation: the custom dragon has been defeated.
# RogueCraft would drag players back to its roguelite hub here. Instead we open the way home:
# a command-summoned dragon does NOT trigger vanilla's exit-portal spawn, so we light the exit
# portal inside the arena's own central spire and place proper vanilla End gateways ourselves.
# Arena geometry (from the bundled island_1 structures): floor top y69, with a crying_obsidian
# spire at world (0,0) rising to y72 — the built-in podium the portal belongs in.

# Stop the fight loop and lock the fight to one-and-done for this world.
data modify storage roguecraft:master end set value 0
data modify storage roguecraft:master end_generation.first_entered set value 1b

# Clean up fight bookkeeping.
tag @a remove end
scoreboard players set #roguecraft_master.ender_dragon dragon_phase 0

# --- Exit portal, recessed INTO the arena's central structure ---
# Exact geometry from the bundled island_1 NBT: solid mound to y68, carved floor at y69, and a
# 1-wide pillar at (0,0): obsidian y70-71 + crying_obsidian cap y72 (the egg pedestal).
# First scrub any stray portal blocks above the floor (old placements / anything mid-air) so nothing
# sits at ankle height where players walk — that exposed pane was warping people home by accident.
execute in minecraft:the_end run fill -3 70 -3 3 78 3 minecraft:air replace minecraft:end_portal
# Migration for worlds touched by the old (wrong) placement: sockets used to sit INSIDE the basin
# at (+-2,69,0)/(0,69,+-2) — convert any obsidian there straight into pool.
execute in minecraft:the_end if block 2 69 0 minecraft:obsidian run setblock 2 69 0 minecraft:air
execute in minecraft:the_end if block -2 69 0 minecraft:obsidian run setblock -2 69 0 minecraft:air
execute in minecraft:the_end if block 0 69 2 minecraft:obsidian run setblock 0 69 2 minecraft:air
execute in minecraft:the_end if block 0 69 -2 minecraft:obsidian run setblock 0 69 -2 minecraft:air

# Restore the pillar base first — (0,69,0) is crying_obsidian in the structure, but an earlier
# (unfiltered) portal fill ate it in existing worlds, leaving the pool to swallow the centre.
# Idempotent: on healthy worlds this re-sets the same block.
execute in minecraft:the_end run setblock 0 69 0 minecraft:crying_obsidian

# The structure's own basin: a 5x5 plus-shape of carved (air) cells at y69 around the pillar
# (solid rim corners, solid pillar base). Filling only AIR lights exactly that basin as the
# portal pool and can never eat the rim or the pillar. Relit on every kill (revival drains it
# back to air, the basin's original state).
execute in minecraft:the_end run fill -2 69 -2 2 69 2 minecraft:end_portal replace minecraft:air

# Obsidian crystal-sockets ON THE RIM (radius 3, flush with the y69 rim top), outside the pool —
# End Crystals only place on obsidian/bedrock; the revival crystals overlook the pool from here.
execute in minecraft:the_end run setblock 3 69 0 minecraft:obsidian
execute in minecraft:the_end run setblock -3 69 0 minecraft:obsidian
execute in minecraft:the_end run setblock 0 69 3 minecraft:obsidian
execute in minecraft:the_end run setblock 0 69 -3 minecraft:obsidian

# First kill only: drop the dragon egg and open the End gateways (vanilla drops the egg once, and
# revival shouldn't keep stacking gateways).
execute unless data storage roguecraft:master {rewards_placed:1b} run function roguecraft:ender_dragon/first_kill_rewards
data modify storage roguecraft:master rewards_placed set value 1b

# Celebratory finish.
execute as @a[nbt={Dimension:"minecraft:the_end"}] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
execute in minecraft:the_end run forceload remove -100 -100 100 100
