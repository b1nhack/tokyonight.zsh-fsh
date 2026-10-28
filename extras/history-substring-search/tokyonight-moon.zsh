# tokyonight.zsh-fsh — history-substring-search integration (style: moon)
#
# Restyles the matched-substring highlight of zsh-history-substring-search,
# whose defaults (bg=magenta / bg=red) clash with Tokyo Night palettes.
#
# Source this AFTER loading zsh-history-substring-search:
#   source ~/.config/fsh/extras/history-substring-search/tokyonight-moon.zsh

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold,fg=#c8d3f5,bg=#3e68d7'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bold,fg=#ff757f'
