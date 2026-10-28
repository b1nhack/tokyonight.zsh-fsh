# tokyonight.zsh-fsh — zsh-autocomplete integration (style: storm)
#
# Restyles the "common substring:" entry of the completion list, whose
# default black-on-color11 rendering is nearly invisible on Tokyo Night
# palettes.
#
# Source this AFTER loading zsh-autocomplete:
#   source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-storm.zsh

zstyle ':completion:*:unambiguous' format \
  $'%B%F{#7aa2f7}common substring:%f%b %F{#c0caf5}%K{#3d59a1}%d%f%k'
