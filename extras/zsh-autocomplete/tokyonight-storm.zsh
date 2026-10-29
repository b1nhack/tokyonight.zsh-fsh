# tokyonight.zsh-fsh — zsh-autocomplete integration (style: storm)
#
# Restyles the completion UI that zsh-autocomplete renders with default or
# hardcoded colors, none of which follow the Tokyo Night palette:
#
#   1. "common substring:" entry — black on ANSI color 11 by default
#      (upstream fallback in Completions/_autocomplete__unambiguous).
#   2. "(MORE)" truncation badge — '%F{0}%K{12}' hardcoded in
#      Functions/Init/.autocomplete__async; raw `compadd -x` bypasses the
#      zstyle `format` machinery, so the widget function is patched.
#   3. History-lines matched-query highlight — SGR `30;103` baked into the
#      `_comp_colors` specs in Completions/_autocomplete__history_lines,
#      overriding the zstyle `list-colors` machinery. The function is
#      `#autoload`ed on first use, so its definition is force-loaded and
#      patched the same way.
#   4. Menu-selection status line ("line 3/85 3%") and scroll line — the
#      plugin sets `select-prompt` to '%F{black}%K{12}line %l %p%f%k' and
#      leaves `select-scroll` at the zsh default; both overridden below.
#   5. Completion messages ("Loading...", "no matching ... completions") —
#      the plugin sets the `messages` format to ANSI bright red '%F{9}'.
#   6. Group headings ("directory", "executable file", ...) — the plugin's
#      autocomplete:config:format renders them with raw SGR `\e[0;1;2m`
#      (faint bold, terminal default color); the function is patched.
#   7. File-type colors and the menu-selection current item in completion
#      listings — complist defaults (reverse-video selection, no file
#      colors, or its built-in bold-red `di` fallback when only a partial
#      set is given), replaced by a complete Tokyo Night list-colors set.
#
# All patches are guarded: they silently skip when zsh-autocomplete is
# absent or the upstream literals changed in a newer version.
#
# Source this AFTER loading zsh-autocomplete:
#   source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-storm.zsh

# 1. "common substring:" — bold blue label; value: fg on bg_search.
zstyle ':completion:*:unambiguous' format \
  $'%B%F{#7aa2f7}common substring:%f%b %F{#c0caf5}%K{#3d59a1}%d%f%k'

# 2. "(MORE)" badge: bold theme-background text on the theme's blue accent.
#    Truecolor, so it no longer depends on the terminal's ANSI palette.
() {
  emulate -L zsh

  local fn='.autocomplete:async:list-choices:completion-widget'
  local old='%F{0}%K{12}(MORE)%f%k'
  local body=$functions[$fn]

  [[ -n $body && $body == *$old* ]] || return 0
  functions[$fn]=${body//$old/$'%B%F{#24283b}%K{#7aa2f7}(MORE)%b%f%k'}
}

# 3. History-lines matched-query highlight: bold theme foreground on
#    bg_search. Truecolor SGR, replacing the hardcoded `30;103`.
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

# 4. Menu-selection status line and scroll line: same badge treatment as
#    the "(MORE)" indicator (bold theme background on blue).
zstyle ':completion:*:default' select-prompt \
  $' %B%F{#24283b}%K{#7aa2f7}line %l %p%b%f%k '
zstyle ':completion:*:default' select-scroll \
  $' %B%F{#24283b}%K{#7aa2f7}line %l %p%b%f%k '

# 5. Completion messages: theme red instead of ANSI bright red.
zstyle ':completion:*:messages' format $'%F{#f7768e}%d%f'

# 6. Group headings: bold theme blue instead of faint terminal default.
#    (Replaces the `\e[0;1;2m` prefix inside the zstyle -e callback.)
() {
  emulate -L zsh

  local fn='autocomplete:config:format'
  local body=$functions[$fn]

  [[ -n $body && $body == *'\e[0;1;2m'* ]] || return 0
  functions[$fn]=${body//'\e[0;1;2m'/'\e[1;38;2;122;162;247m'}
}

# 7. File-type colors + menu-selection current item. Complete set: a
#    partial one would let complist fall back to its built-in defaults
#    (e.g. bold-red directories).
zstyle ':completion:*' list-colors \
  'di=38;2;122;162;247' \
  'ln=38;2;125;207;255' \
  'so=38;2;187;154;247' \
  'pi=38;2;224;175;104' \
  'bd=38;2;224;175;104' \
  'cd=38;2;224;175;104' \
  'ex=38;2;158;206;106' \
  'su=0;38;2;224;175;104;48;2;41;46;66' \
  'sg=0;38;2;224;175;104;48;2;41;46;66' \
  'tw=0;38;2;26;27;38;48;2;158;206;106' \
  'ow=0;38;2;26;27;38;48;2;158;206;106' \
  'st=0;38;2;26;27;38;48;2;122;162;247' \
  'ma=1;38;2;192;202;245;48;2;61;89;161'
