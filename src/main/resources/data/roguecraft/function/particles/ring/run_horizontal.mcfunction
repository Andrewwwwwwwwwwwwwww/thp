#particle_type, speed, force
#send particle
$execute rotated $(particle_angle_current) $(other_angle) run particle $(particle_type) ~ ~ ~ ^ ^ ^1000000000 $(speed) 0 $(force)

#remove remaining steps and break loop
scoreboard players remove @s particle_steps 1
execute if score @s particle_steps matches ..0 run return 0

#add to angle and store result
scoreboard players operation @s particle_angle_current += @s particle_angle_step
function roguecraft:particles/ring/store_scores

#recursion
function roguecraft:particles/ring/run_horizontal with storage roguecraft:master particles