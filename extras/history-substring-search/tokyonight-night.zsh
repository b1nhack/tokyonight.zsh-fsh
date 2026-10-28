# tokyonight.zsh-fsh — history-substring-search integration (style: night)
#
# Restyles the matched-substring highlight of zsh-history-substring-search,
# whose defaults (bg=magenta / bg=red) clash with Tokyo Night palettes.
#
# Source this AFTER loading zsh-history-substring-search:
#   source ~/.config/fsh/extras/history-substring-search/tokyonight-night.zsh

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold,fg=#c0caf5,bg=#3d59a1'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bold,fg=#f7768e'
