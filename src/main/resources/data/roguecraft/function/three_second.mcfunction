# THP adaptation: slow control loop (folds RogueCraft's three_second + ender_dragon/check_alive).
# Self-reschedules every 60 ticks. Kicked off from roguecraft:setup.

execute unless score #thp portal_activated matches 1 run return run schedule function roguecraft:three_second 60t

# Summon the dragon once the arena is armed (end:1, health primed to 1000) but no
# dragon exists yet and the arena is loaded. dragon_health leaves 1000 the moment
# the fight's tick reads the spawned dragon's real health, so this only fires once.
execute if score #roguecraft_master.ender_dragon dragon_health matches 1000 if entity @a[gamemode=!spectator,nbt={Dimension:"minecraft:the_end"}] if data storage roguecraft:master {end:1} unless entity @e[type=minecraft:ender_dragon] in minecraft:the_end if loaded -100 0 -100 if loaded 100 0 100 run function custom_ender_dragon:summon_dragon
execute if score #roguecraft_master.ender_dragon dragon_health matches 1000 if entity @a[gamemode=!spectator,nbt={Dimension:"minecraft:the_end"}] if data storage roguecraft:master {end:1} in minecraft:the_end if loaded -100 0 -100 if loaded 100 0 100 at @e[type=minecraft:ender_dragon] run summon minecraft:lightning_bolt

# Finish when the dragon was spawned (health left 1000) and is now gone. The dragon
# dies via vanilla (instakill sets Health 0), so the vanilla exit portal + End gateway
# spawn on their own; we just stop the fight loop and mark it done for good.
execute unless score #roguecraft_master.ender_dragon dragon_health matches 1000 if entity @a[gamemode=!spectator,nbt={Dimension:"minecraft:the_end"}] if data storage roguecraft:master {end:1} unless entity @e[type=minecraft:ender_dragon] in minecraft:the_end if loaded -100 0 -100 if loaded 100 0 100 run function roguecraft:ender_dragon/finish

schedule function roguecraft:three_second 60t
