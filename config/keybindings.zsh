bindkey "^P" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^[[1;5D" backward-word
bindkey "^[[D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[C" forward-word

bindkey "^H" backward-delete-char
bindkey "^K" kill-line
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^[^?" backward-kill-word

bindkey "^J" accept-line
bindkey "^L" clear-screen
bindkey "^O" overwrite-mode
bindkey "^Q" push-line
bindkey "^V" quoted-insert
bindkey "^X^E" edit-command-line
bindkey "^Xa" _expand_alias
bindkey "^Y" yank
bindkey "^[[Z" reverse-menu-complete
bindkey "^_" undo
bindkey -s "^X^K" "^E^U"

bindkey -s "^B" "^Qd^M"
bindkey -s "^[u" "^Qcd ..^M"

bindkey -s "^Gd" "^Qgit diff^M"
bindkey -s "^Gl" "^Qgit l^M"
bindkey -s "^Gs" "^Qgit st^M"

bindkey -s "^Xf" "^Qranger^M"
bindkey -s "^Xr" "^Qexec \$SHELL^M"

bindkey -s "^[[15~" "^P^J"
