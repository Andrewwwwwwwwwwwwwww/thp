execute in minecraft:the_end run summon minecraft:marker -32 0 -48 {Tags:["end_gen_marker"],data:{phase:2,coordinate:e6}}
execute in minecraft:the_end run summon minecraft:marker -16 0 -48 {Tags:["end_gen_marker"],data:{phase:2,coordinate:e7}}
execute in minecraft:the_end run summon minecraft:marker 0 0 -48 {Tags:["end_gen_marker"],data:{phase:2,coordinate:e8}}
execute in minecraft:the_end run summon minecraft:marker 16 0 -48 {Tags:["end_gen_marker"],data:{phase:2,coordinate:e9}}

execute in minecraft:the_end run summon minecraft:marker -48 0 -32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:f5}}
execute in minecraft:the_end run summon minecraft:marker -32 0 -32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:f6}}
execute in minecraft:the_end run summon minecraft:marker 16 0 -32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:f9}}
execute in minecraft:the_end run summon minecraft:marker 32 0 -32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:f10}}

execute in minecraft:the_end run summon minecraft:marker -48 0 -16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:g5}}
execute in minecraft:the_end run summon minecraft:marker 32 0 -16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:g10}}
execute in minecraft:the_end run summon minecraft:marker 48 0 -16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:g11}}

execute in minecraft:the_end run summon minecraft:marker -48 0 0 {Tags:["end_gen_marker"],data:{phase:2,coordinate:h5}}
execute in minecraft:the_end run summon minecraft:marker 32 0 0 {Tags:["end_gen_marker"],data:{phase:2,coordinate:h10}}
execute in minecraft:the_end run summon minecraft:marker 48 0 0 {Tags:["end_gen_marker"],data:{phase:2,coordinate:h11}}

execute in minecraft:the_end run summon minecraft:marker -48 0 16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:i5}}
execute in minecraft:the_end run summon minecraft:marker -32 0 16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:i6}}
execute in minecraft:the_end run summon minecraft:marker 32 0 16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:i10}}
execute in minecraft:the_end run summon minecraft:marker 48 0 16 {Tags:["end_gen_marker"],data:{phase:2,coordinate:i11}}

execute in minecraft:the_end run summon minecraft:marker -32 0 32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:j6}}
execute in minecraft:the_end run summon minecraft:marker -16 0 32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:j7}}
execute in minecraft:the_end run summon minecraft:marker 0 0 32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:j8}}
execute in minecraft:the_end run summon minecraft:marker 16 0 32 {Tags:["end_gen_marker"],data:{phase:2,coordinate:j9}}

execute as @e[tag=end_gen_marker] at @s run function custom_ender_dragon:generate/generate_end with entity @s data