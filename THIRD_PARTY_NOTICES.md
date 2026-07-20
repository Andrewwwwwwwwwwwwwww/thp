# Third-Party Notices

## RogueCraft — custom Ender Dragon fight

The Hungering Portal bundles a custom End boss fight (the multi-phase Ender Dragon,
its arena, attacks, and loot) that is **derived from RogueCraft by MonoCode**.

- **Work:** RogueCraft
- **Author:** MonoCode
- **Source:** https://modrinth.com/datapack/rogue-craft
- **License:** Creative Commons Attribution-ShareAlike 4.0 International (CC-BY-SA-4.0)
  — https://creativecommons.org/licenses/by-sa/4.0/

### What is included and what changed
The bundled data (in the mod jar under `data/custom_ender_dragon/` and the supporting
`data/roguecraft/` helpers) is taken from RogueCraft v1.3.9.1 and adapted so the fight
runs standalone inside The Hungering Portal rather than as part of the RogueCraft
roguelite. Specifically:

- The fight's functions, arena structures, and loot tables are used as-is.
- RogueCraft's roguelite framework was replaced with a minimal driver: the fight is
  armed only after the Hungering Portal ritual is complete, run-based difficulty
  scaling and the skillpoint/hub systems are removed (no-ops), and on the dragon's
  death the standard End exit portal and End gateways are generated so players return
  home and can explore the End normally (RogueCraft instead returns players to its hub).

### License obligations (CC-BY-SA-4.0)
As required by the license, the bundled/derived End-fight content above is provided
under **CC-BY-SA-4.0**, with attribution to MonoCode. Modifications have been made as
described. The rest of The Hungering Portal (its Java source and original assets) is
covered by the project's own `LICENSE`; only the derived End-fight data carries
CC-BY-SA-4.0.
