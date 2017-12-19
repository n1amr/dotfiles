# ^X => ctrl + x
# ^[x => alt + x

bindkey "^P" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

bindkey "^[OH" beginning-of-line
bindkey "^A" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^[[1;5D" backward-word
bindkey "^[[D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[C" forward-word

bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^K" kill-line
bindkey "^U" vi-kill-line
bindkey "^W" backward-kill-word
bindkey "^[^?" backward-kill-word

bindkey -s "^[#" "^[OH#^J"  # insert comment

bindkey "^_" undo
bindkey "^J" accept-line
bindkey "^O" accept-line-and-down-history
bindkey "^L" clear-screen
bindkey "^O" overwrite-mode
bindkey "^V" quoted-insert
bindkey "^X^E" edit-command-line
bindkey -a "v" edit-command-line
bindkey "^Q" push-line
bindkey "^Xa" _expand_alias
bindkey "^Y" yank
bindkey "^[." insert-last-word
bindkey "^[[Z" reverse-menu-complete
bindkey -s "^X^K" "^E^U"

bindkey -s "^X^X" "^Qkeybindings^M"

bindkey -s "^[[15~" "^Q^P^J"
bindkey -s "^[r" "^Qr^M"
bindkey -s "^[u" "^Qcd ..^M"

bindkey -s "^Xr" "^Qexec \$SHELL^M"

# git
bindkey -s "^Gd" "^Qgit diff^M"
bindkey -s "^Gl" "^Qgit l^M"
bindkey -s "^Gs" "^Qgit st^M"
