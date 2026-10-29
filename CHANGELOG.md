# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.2.0] - 2026-10-28

### Added

- zsh-autocomplete integration now also restyles two more hardcoded spots:
  - the `(MORE)` badge shown when the async completion listing is
    truncated. Upstream hardcodes it as ANSI black on bright blue via raw
    `compadd -x` (which bypasses the zstyle `format` machinery), leaving
    no official hook — the extras patch the widget function after the
    plugin loads, replacing it with a truecolor bold
    theme-background-on-blue badge.
  - the matched-query highlight in the history-lines listing. Upstream
    bakes SGR `30;103` (black on bright yellow) into the `_comp_colors`
    pattern specs, overriding the zstyle `list-colors` machinery. The
    extras force-load the `#autoload`ed completion function and patch the
    literals with a truecolor bold foreground-on-`bg_search` spec.
  Both patches are guarded and silently skip when the upstream literals
  are not found (e.g. on newer/older plugin versions). This supersedes
  the previously documented "known limitation" for history-lines.

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
