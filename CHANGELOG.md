# The Hungering Portal Changelog

## [2.1.0] - 2026-07-20

### Added
- **A custom, multi-phase Ender Dragon fight.** After the portal ritual is complete and players
  first enter the End, an overhauled dragon boss plays out in a custom arena: an aerial phase
  (fireballs, meteors, TNT lines, lightning endermen), a shulker-summoning "Hyper Jean" phase
  (lightning rings, homing missiles, a splitting dragon, teleports), a wave-based add fight, and
  a healing-crystal finale. The vanilla dragon fight is fully suppressed; the surrounding vanilla
  End island is cleared and replaced by the custom arena, generated on first entry while players
  are held safely above it.
- When the dragon dies, the **exit portal lights inside the arena's central fountain** (a sunken
  portal pool around the dragon-egg pillar) and **full vanilla End gateways** are generated, so
  players can return home and explore the outer End as usual.
- **The dragon can be revived vanilla-style**: place 4 End Crystals on the obsidian pads around
  the exit portal to respawn it and run the whole fight again (the portal goes dark during the
  fight and relights on victory; the egg and gateways only appear on the first kill).

### Changed
- **Offerings updated**: the Recovery Compass is replaced by **16 Wither Roses** (throw in any
  stacks — partial progress counts and is returned if the portal times out), and the Pigstep
  Music Disc is replaced by a **Conduit**.
- `/thp portalreq` now prints the requirements **in chat only**; the on-screen title sequence
  plays only when a player jumps into a not-yet-opened portal.

### Notes
- The fight is **derived from [RogueCraft](https://modrinth.com/datapack/rogue-craft) by MonoCode**,
  used under **CC-BY-SA-4.0** and adapted to run standalone (roguelite difficulty scaling, skillpoints,
  and hub return removed). See `THIRD_PARTY_NOTICES.md`. That bundled data carries CC-BY-SA-4.0; the
  mod's own code/assets remain under the project license.
- Wave mobs use base vanilla stats (RogueCraft's run-based difficulty scaling does not apply here).

## [2.0.0] - 2026-06-27

### Changed
- **Stable 2.0.0 release.** No gameplay changes from 1.5.0 — this marks the mod stable and aligns it with
  the unified release across the mod suite.
- **Jar filenames now include the Minecraft version** (e.g. `thp-2.0.0+mc26.2.jar`) so the 26.2 and
  26.1.2 downloads are unambiguous.
- A parallel **MC 26.1.2** build is now published (`thp-2.0.0+mc26.1.2.jar`) for players still on the
  older version.

## [1.5.0] - 2026-06-16

### Changed
- **Updated to Minecraft 26.2.** Bumped to Fabric Loader 0.19.3 and Fabric API 0.152.1+26.2
  (Fabric Loom stays at 1.16.2 — 1.17.x requires Gradle 9.5, above the workspace's 9.4.0 wrapper).
  Dependency bounds in `fabric.mod.json` raised to match (`minecraft ~26.2`, `fabricloader >=0.19.3`,
  `fabric-api >=0.152.1`). No gameplay changes.

## [1.4.0] - 2026-06-09

### Changed
- **Rebranded EndBeast → "The Hungering Portal".** The mod name (and Mod Menu entry), the mod id
  (`endbeast` → `thp`), and the jar filename (`thp-x.x.x.jar`) all use the new name. The command is
  now **`/thp`** (subcommands unchanged: `portalreq`, `setendplayercount`, `reset`).
- **`/endbeast` still works** as a backwards-compatible alias.
- In-game ritual flavor text ("The End Portal hungers…") is intentionally unchanged. Existing world
  state in `<world>/endbeast.json` is preserved (the save filename is kept for continuity).

## [1.3.0] - 2026-06-04

### Added
- `/endbeast reset` (ops only) — re-locks the End Portal so the full ritual is required again.
  Clears the activated state and any in-progress ritual progress, and announces "The End Portal
  hungers once more." (In-progress offerings are not returned.)

---

## [1.2.3] - 2026-05-29

### Changed
- Chat requirement list now appends the actual item name in parentheses after each poetic clue, e.g. `A hand held savior (Totem of Undying)`, making it immediately clear what to collect.

---

## [1.2.2] - 2026-05-28

### Fixed
- Mod Menu config screen and README referenced the command as `/EndBeast`; corrected to `/endbeast` to match the case-sensitive Brigadier registration.

---

## [1.2.1] - 2026-05-28

### Added
- Mod Menu integration — players can configure the required participant count via the in-game mod list without using commands. Multiplayer clients see a read-only screen with the relevant commands instead.
- Icon updated to 400×400 RGBA PNG for CurseForge logo compatibility.

---

## [1.2.0] - 2026-05-27

### Added
- Five new required offerings: Beacon, Mace, Recovery Compass, Pigstep Music Disc, Zombie Head — bringing the total to ten items.
- Player-count requirement line added to the chat backup that fires after the on-screen slideshow, so witnesses needed is always visible in the chat history.
- Title/subtitle display now adapts to GUI scale — large titles use a subtitle line instead of cramming text into the title, preventing overflow at GUI scale 3+.

---

## [1.1.1] - 2026-05-15

### Fixed
- Command `/EndBeast` renamed to `/endbeast` — Brigadier is case-sensitive; the old name was awkward and non-standard.
- Mixin `compatibilityLevel` corrected from `JAVA_21` to `JAVA_25` to match the project's compile target.
- Memory leak: `pendingChats`, `pendingTitles`, and `lastMessageTick` are now cleared when the server reloads, preventing stale UI state from carrying over in development environments.

### Changed
- Fabric Loom pinned to `1.16.2` (stable) — was previously on `1.16-SNAPSHOT`.
- Fabric API dependency tightened to `>=0.148.2` instead of the wildcard `*`.

### Added
- MIT `LICENSE` file added to the repository and packaged in the JAR.
- Updated mod icon (full end portal frame structure with stars).

---

## [1.1.0] - 2026-05-15

### Added
- `/endbeast portalreq` command — shows the portal requirements on screen and in chat without needing to interact with the portal.
- Title/subtitle slideshow for requirements display — each item scrolls through sequentially on-screen, with a chat backup after the sequence ends.
- Repackaged to `io.github.andrewwwwwwwwwwwwwww.endbeast` namespace.
- SLF4J logger replaces raw stderr output.
- `fabric.mod.json` contact metadata (homepage, sources, issues).
- README.md with full feature and install documentation.

### Fixed
- Mixin descriptor corrected to include the missing `boolean` parameter in `entityInside` — the mixin previously failed to inject.
- LP-box title rendering replaced with a proper title slideshow sequence that doesn't interfere with other UI.

---

## [1.0.4] - 2026-05-15

### Added
- Chat message queued after the title/subtitle sequence fades so players have a text reference after the on-screen display is gone.

### Changed
- Portal requirements now displayed on-screen via title/subtitle packets instead of only in chat.

---

## [1.0.1] - 2026-05-15

### Added
- Initial public release (renamed from `enterend`).
- End Portal ritual gate: 12 eyes of ender light the portal, but players are repelled until five specific offerings are thrown in and a minimum number of witnesses are present.
- Required offerings: Trident, Netherite Block, Sniffer Egg, Enchanted Golden Apple, Totem of Undying.
- 60-second offering timeout — if players take too long between offerings the portal returns all items.
- Configurable minimum participant count via `/EndBeast setendplayercount <n>`.
- Persistent world state saved to `<world>/endbeast.json`.
- Activation is world-wide and permanent once triggered.
