# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.3.0] - 2026-10-31

### Fixed

- **Invisible nested code** — interiors of `` `...` ``, `$( ... )` and `eval`
  arguments were recursively highlighted with upstream's shipped 256-color
  `zdharma` secondary theme, whose command color (`#5f5fdf` dark blue) is
  nearly invisible on the dark variants (e.g. the `nproc` in
  ``make ... -j `nproc` ``). Following catppuccin/zsh-fsh, `secondary` is now
  left **empty**: F-Sy-H still re-highlights nested code, but with this same
  Tokyo Night theme instead of switching to a secondary theme.

### Changed

- `correct-subtle` / `incorrect-subtle` are now foreground-only styles
  (theme `blue` / `red`, as in fsh's own themes and catppuccin/zsh-fsh).
  F-Sy-H's `make` chroma flags make targets by recoloring text, so command
  substitutions like `` `nproc` `` — which it misreads as a target — are no
  longer painted with a background box. The old backgrounds were muddy
  browns (`night` `#4a272f`; `day` even used the joke hex `#dababe`).
- `paired-bracket` now follows tokyonight.nvim's actual `MatchParen` highlight
  — bold orange (`#ff9e64` / `#ff966c` / `#b15c00`) — instead of painting a
  `bg_search` background under the matching pair. The editor itself never
  puts text on `bg_search`, and the old background dragged the bracket color
  down to 1.3–2.7:1 contrast on `day`. Every color in every INI is an exact
  tokyonight.nvim palette value, verified against upstream's generated
  `extras/lua/tokyonight_*.lua` tables.
- Previews: `scripts/generate_previews.py` now resolves styles through
  fast-theme's fallback chain (e.g. `for-loop-variable` → `forvar`), and the
  demo gained command-substitution lines (``make ... -j `nproc` `` and
  `echo $(uname -m)`) showcasing recursive highlighting.

## [1.2.0] - 2026-10-28

### Added

- zsh-autocomplete integration: complete restyle of the completion UI
  that upstream renders with default or hardcoded colors:
  - `(MORE)` truncation badge — ANSI black on bright blue via raw
    `compadd -x` (bypasses the zstyle `format` machinery); now a
    truecolor bold theme-background-on-blue badge via a function patch.
  - history-lines matched-query highlight — SGR `30;103` baked into the
    `_comp_colors` specs; the `#autoload`ed function is force-loaded and
    patched with a truecolor bold foreground-on-`bg_search` spec.
    Supersedes the previously documented "known limitation".
  - menu-selection status line (`line 3/85 3%`) and scroll line — the
    plugin sets `select-prompt` to ANSI black on bright blue and leaves
    `select-scroll` at the zsh default; both overridden zstyles.
  - completion messages (`Loading...`) — ANSI bright red replaced with
    the theme red.
  - group headings (`directory`, `commands`, ...) — the `zstyle -e`
    callback's raw faint-bold SGR patched to bold theme blue.
  - file-type colors and the menu-selection current item in completion
    listings — a complete Tokyo Night `list-colors` set (directories,
    symlinks, sockets, devices, executables, setuid/setgid, sticky and
    world-writable dirs, current item). Kept complete on purpose:
    complist fills unset entries with its own defaults (e.g. bold-red
    directories).
  Every function patch is guarded and silently skips when the upstream
  literals are not found (e.g. on newer/older plugin versions).

## [1.1.0] - 2026-10-28

### Added

- zsh-autocomplete integration: `extras/zsh-autocomplete/tokyonight-<style>.zsh`
  restyles the `common substring:` completion-list entry, whose default
  black-on-color11 rendering is nearly invisible on Tokyo Night palettes.
  `install.sh` copies these files and prints the `source` line.
- history-substring-search integration:
  `extras/history-substring-search/tokyonight-<style>.zsh` restyles the
  matched-substring highlight (`HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND`
  uses bold foreground on `bg_search`; not-found uses bold red).

## [1.0.0] - 2026-10-28

### Added

- Tokyo Night themes for Fast Syntax Highlighting (F-Sy-H), covering every
  F-Sy-H style key (59 styles), as truecolor INI files:
  - `themes/tokyonight-night.ini` — palette of tokyonight.nvim `night`
  - `themes/tokyonight-storm.ini` — palette of tokyonight.nvim `storm`
  - `themes/tokyonight-moon.ini` — palette of tokyonight.nvim `moon`
  - `themes/tokyonight-day.ini` — palette of tokyonight.nvim `day`
- `install.sh` — installs themes to `~/.config/fsh/` and activates one.
- `scripts/generate_previews.py` — regenerates the SVG previews in `assets/`.
- Previews for all four variants.
