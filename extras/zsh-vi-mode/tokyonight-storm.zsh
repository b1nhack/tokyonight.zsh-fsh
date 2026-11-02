# tokyonight.zsh-fsh — zsh-vi-mode integration (style: storm)
#
# Restyles every highlight zsh-vi-mode paints itself: the visual and
# visual-line selection, the transient surround-delimiter highlight and
# the repeat (".") preview. Its defaults (bg #cc0000, fg #eeeeee) clash
# with the Tokyo Night palettes, and the fast-syntax-highlighting theme
# has no region color of its own -- zsh-vi-mode appends its region on
# top of whatever fsh painted.
#
# Source this AFTER loading zsh-vi-mode:
#   source ~/.config/fsh/extras/zsh-vi-mode/tokyonight-storm.zsh

ZVM_VI_HIGHLIGHT_BACKGROUND=#2e3c64   # selection blue (tokyonight-storm.ini)
ZVM_VI_HIGHLIGHT_FOREGROUND=#c0caf5   # default foreground
