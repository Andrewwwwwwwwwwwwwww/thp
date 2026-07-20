# THP adaptation of RogueCraft's setup — runs on datapack load (minecraft:load tag).
# Only what the custom Ender Dragon fight needs; the roguelite systems are dropped.

# THP <-> fight bridge: THP's Java sets this to 1 once the Hungering Portal ritual
# is complete, which is what arms the custom End fight.
scoreboard objectives add portal_activated dummy
scoreboard objectives add thp_count dummy

# Fight scoreboards + bossbar (delegated to the fight's own setup).
function custom_ender_dragon:setup

# Persistent state flags the fight reads. Initialise once; never clobber an
# in-progress fight or a completed one on reload.
execute unless data storage roguecraft:master end run data modify storage roguecraft:master end set value 0
execute unless data storage roguecraft:master end_generation run data modify storage roguecraft:master end_generation set value {}

# Kick the slow control loop.
schedule function roguecraft:three_second 60t
