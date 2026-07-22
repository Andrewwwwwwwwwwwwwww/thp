# Translating The Hungering Portal

Everything a player sees — the portal ritual titles and chat, the offering list, and the Mod Menu
config screen — is translatable. There is one file to translate: `en_us.json`.

## For translators

1. Start from the English template:
   [`src/main/resources/assets/thp/lang/en_us.json`](src/main/resources/assets/thp/lang/en_us.json)
   (46 entries).
2. Translate only the **values**, never the keys.
3. **Keep the placeholders**: `%d` is a number (witness counts, offering index). Leave them in place;
   you may reorder with `%1$d` etc. if your language needs it.
4. Save as `<locale>.json` using your Minecraft language code — e.g. `zh_tw.json`, `es_es.json`,
   `de_de.json`. Save as **UTF-8**. Partial translations are fine — anything untranslated shows English.

### Key groups
| Prefix | What it is |
| --- | --- |
| `thp.req.*` | The offering list: heading, each item's flavor line + name, and the witness-count line |
| `thp.offerings_made.*` | The "all items in, still need witnesses" title/chat (singular `_one` / plural `_many`) |
| `thp.open.*` / `thp.reset.*` / `thp.return.*` | Portal opened / re-locked / timed-out messages |
| `thp.cmd.*` | Command feedback |
| `thp.config.*` | The Mod Menu config screen |

## For the server owner (installing a translation)

The portal titles and chat are drawn by the **server**, per player, from the language their client
reports. Two ways to install a finished translation:

- **This server only:** drop the file at `<world>/thp/lang/<locale>.json` and restart. Overrides win.
- **Bundle for everyone / the config screen:** the Mod Menu config screen is client-side, so a
  bundled `<locale>.json` in the jar (`assets/thp/lang/`) covers both the server messages and the
  screen. Send finished translations to the author to be bundled into a release.
