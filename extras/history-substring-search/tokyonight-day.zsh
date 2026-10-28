# tokyonight.zsh-fsh — history-substring-search integration (style: day)
#
# Restyles the matched-substring highlight of zsh-history-substring-search,
# whose defaults (bg=magenta / bg=red) clash with Tokyo Night palettes.
#
# Source this AFTER loading zsh-history-substring-search:
#   source ~/.config/fsh/extras/history-substring-search/tokyonight-day.zsh

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold,fg=#3760bf,bg=#7890dd'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bold,fg=#f52a65'
