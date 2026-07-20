#start_angle, total_steps, vertical, other_angle, particle_type, speed, force

#set scores
$scoreboard players set @s particle_angle_current $(start_angle)
$scoreboard players set @s particle_steps $(total_steps)
$scoreboard players set @s particle_mode $(vertical)
scoreboard players operation @s particle_angle_step = 3600 int
scoreboard players operation @s particle_angle_step /= @s particle_steps

#set data
$data modify storage roguecraft:master particles set value {particle_type:"$(particle_type)",speed:$(speed),force:"$(force)",other_angle:$(other_angle)}
function roguecraft:particles/ring/store_scores

#execute mode
execute if score @s particle_mode matches 0 run function roguecraft:particles/ring/run_horizontal with storage roguecraft:master particles
execute if score @s particle_mode matches 1 run function roguecraft:particles/ring/run_vertical with storage roguecraft:master particles

#end it all
kill @s