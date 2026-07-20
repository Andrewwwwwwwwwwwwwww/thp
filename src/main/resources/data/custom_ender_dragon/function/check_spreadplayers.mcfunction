$execute store success storage roguecraft:master success byte 1 run execute in minecraft:the_end run spreadplayers 0 0 1 $(distance) false @s

execute if data storage roguecraft:master {success:1b} run return run function roguecraft:misc/teleport_effect

execute in minecraft:the_end run fill -2 70 -2 2 71 2 minecraft:air destroy
execute in minecraft:the_end run fill -2 69 -2 2 69 2 minecraft:purpur_block outline
execute in minecraft:the_end run fill -1 69 -1 1 69 1 minecraft:end_stone_bricks
$execute in minecraft:the_end run spreadplayers 0 0 1 $(distance) false @s

function roguecraft:misc/teleport_effect