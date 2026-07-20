#check if loaded
execute unless loaded ~-2 ~ ~-2 run return fail
execute unless loaded ~2 ~ ~2 run return fail

#remove gateway and self
fill ~-2 ~-2 ~-2 ~2 ~2 ~2 minecraft:air
kill @s