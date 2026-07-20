# THP adaptation: RogueCraft's roguelite skillpoint system does not exist here.
# The fight still calls this on each phase transition, so keep only the
# celebratory pickup sound and drop the skillpoint scoreboard / tellraw.
execute at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.25
