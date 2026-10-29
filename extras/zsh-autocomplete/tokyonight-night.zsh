# tokyonight.zsh-fsh — zsh-autocomplete integration (style: night)
#
# Restyles three completion-list items whose default renderings are hard
# to read on Tokyo Night palettes:
#
#   1. The "common substring:" entry — black on ANSI color 11 by default.
#   2. The "(MORE)" badge appended when the async listing is truncated —
#      hardcoded upstream (Functions/Init/.autocomplete__async) as
#      '%F{0}%K{12}(MORE)%f%k', i.e. ANSI black on ANSI bright blue. It is
#      added via raw `compadd -x`, which bypasses the zstyle `format`
#      machinery, so we patch the widget function after the plugin loads.
#   3. The matched-query highlight in the history-lines listing —
#      hardcoded upstream (Completions/_autocomplete__history_lines) as
#      SGR `30;103` (ANSI black on bright yellow) inside the `_comp_colors`
#      pattern specs, which overrides the zstyle `list-colors` machinery.
#      The function is `#autoload`ed on first use, so we force-load its
#      definition and patch it the same way.
#
# All patches are guarded: they silently skip when zsh-autocomplete is
# absent or the upstream literals changed in a newer version.
#
# Source this AFTER loading zsh-autocomplete:
#   source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-night.zsh

zstyle ':completion:*:unambiguous' format \
  $'%B%F{#7aa2f7}common substring:%f%b %F{#c0caf5}%K{#3d59a1}%d%f%k'

# "(MORE)" badge: bold theme-background text on the theme's blue accent.
# Truecolor, so it no longer depends on the terminal's ANSI palette.
() {
  emulate -L zsh

  local fn='.autocomplete:async:list-choices:completion-widget'
  local old='%F{0}%K{12}(MORE)%f%k'
  local body=$functions[$fn]

  [[ -n $body && $body == *$old* ]] || return 0
  functions[$fn]=${body//$old/$'%B%F{#1a1b26}%K{#7aa2f7}(MORE)%b%f%k'}
}

# History-lines matched-query highlight: bold theme foreground on
# bg_search (same treatment as the "common substring:" entry). Truecolor
# SGR, replacing the hardcoded `30;103` in the `_comp_colors` specs.
() {
  emulate -L zsh

  local fn=_autocomplete__history_lines
  (( $+functions[$fn] )) ||
      builtin autoload -RUz +X $fn 2>/dev/null ||
      return 0
  local body=$functions[$fn]
  [[ -n $body && $body == *'30;103'* ]] || return 0
  functions[$fn]=${body//'30;103'/'1;38;2;192;202;245;48;2;61;89;161'}
}
