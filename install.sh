#!/usr/bin/env zsh
# tokyonight.zsh-fsh — install a Tokyo Night theme for Fast Syntax Highlighting.
#
# Usage:
#   ./install.sh [night|storm|moon|day]
#
# Copies the chosen theme into ${XDG_CONFIG_HOME:-$HOME/.config}/fsh/ and, when
# run from a shell where Fast Syntax Highlighting (F-Sy-H) is already loaded,
# activates it immediately via `fast-theme`.
#
# Without F-Sy-H loaded, the theme is still installed; just run
#   fast-theme XDG:tokyonight-<variant>
# from any shell where the plugin is loaded.

emulate -LR zsh
setopt err_exit no_unset pipefail

local script_dir=${0:A:h}
local -a variants=(night storm moon day)

local usage="usage: ./install.sh [night|storm|moon|day]"

local variant=${1:-night}
if [[ ${variants[(Ie)$variant]} -eq 0 ]]; then
  print -u2 "tokyonight.zsh-fsh: unknown variant '$variant'"
  print -u2 $usage
  exit 1
fi

local ini="$script_dir/themes/tokyonight-$variant.ini"
[[ -r $ini ]] || { print -u2 "tokyonight.zsh-fsh: cannot read $ini"; exit 1 }

local dest="${XDG_CONFIG_HOME:-$HOME/.config}/fsh"
command mkdir -p "$dest"
command cp -v "$ini" "$dest/tokyonight-$variant.ini"

# Also install the remaining variants, so switching later needs no re-install.
for v in $variants; do
  [[ $v == $variant ]] && continue
  command cp "$script_dir/themes/tokyonight-$v.ini" "$dest/tokyonight-$v.ini"
done

# Optional integration for zsh-autocomplete's "common substring:" line.
local extra_dir="$script_dir/extras/zsh-autocomplete"
if [[ -d $extra_dir ]]; then
  command mkdir -p "$dest/extras/zsh-autocomplete"
  command cp "$extra_dir"/*.zsh "$dest/extras/zsh-autocomplete/"
fi

# Optional integration for zsh-history-substring-search's match highlight.
extra_dir="$script_dir/extras/history-substring-search"
if [[ -d $extra_dir ]]; then
  command mkdir -p "$dest/extras/history-substring-search"
  command cp "$extra_dir"/*.zsh "$dest/extras/history-substring-search/"
fi

if (( ${+functions[fast-theme]} )); then
  fast-theme "XDG:tokyonight-$variant"
  print "Done. Theme 'tokyonight-$variant' is active (this session and future sessions)."
else
  print "Installed to $dest."
  print "Activate it from a shell with Fast Syntax Highlighting loaded:"
  print "  fast-theme XDG:tokyonight-$variant"
fi

print "Optional: if you use zsh-autocomplete, also add this line to your zshrc"
print "(after the plugin) — it fixes the nearly-invisible 'common substring' entry:"
print "  source ${dest}/extras/zsh-autocomplete/tokyonight-$variant.zsh"
print "Optional: if you use zsh-history-substring-search, add (after the plugin):"
print "  source ${dest}/extras/history-substring-search/tokyonight-$variant.zsh"
