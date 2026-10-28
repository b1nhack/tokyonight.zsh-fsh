# tokyonight.zsh-fsh — zsh-autocomplete integration (style: day)
#
# Restyles the "common substring:" entry of the completion list, whose
# default black-on-color11 rendering is nearly invisible on Tokyo Night
# palettes.
#
# Source this AFTER loading zsh-autocomplete:
#   source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-day.zsh

zstyle ':completion:*:unambiguous' format \
  $'%B%F{#2e7de9}common substring:%f%b %F{#3760bf}%K{#7890dd}%d%f%k'
