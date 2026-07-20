# THP: one-time rewards for the very first kill — the dragon egg and the End gateways.

# Dragon egg atop the central spire (top block is y72).
execute in minecraft:the_end run setblock 0 73 0 minecraft:dragon_egg

# Full vanilla End gateways (bedrock shell + gateway block + beam) via the real feature.
# end_gateway_delayed (exact:false) generates/finds an outer-island exit on first use.
execute in minecraft:the_end run place feature minecraft:end_gateway_delayed 96 75 0
execute in minecraft:the_end run place feature minecraft:end_gateway_delayed -96 75 0
execute in minecraft:the_end run place feature minecraft:end_gateway_delayed 0 75 96
execute in minecraft:the_end run place feature minecraft:end_gateway_delayed 0 75 -96
