# tokyonight.zsh-fsh — zsh-autocomplete integration (style: moon)
#
# Restyles the "common substring:" entry of the completion list, whose
# default black-on-color11 rendering is nearly invisible on Tokyo Night
# palettes.
#
# Source this AFTER loading zsh-autocomplete:
#   source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-moon.zsh

zstyle ':completion:*:unambiguous' format \
  $'%B%F{#82aaff}common substring:%f%b %F{#c8d3f5}%K{#3e68d7}%d%f%k'
