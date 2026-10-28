# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.1.0] - 2026-10-28

### Added

- zsh-autocomplete integration: `extras/zsh-autocomplete/tokyonight-<style>.zsh`
  restyles the `common substring:` completion-list entry, whose default
  black-on-color11 rendering is nearly invisible on Tokyo Night palettes.
  `install.sh` copies these files and prints the `source` line.

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
