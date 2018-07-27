# \C-x => ctrl + x
# \ex => alt + x

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'
bind '"\C-r": reverse-search-history'
bind '"\C-s": forward-search-history'

bind '"\C-a": beginning-of-line'
bind '"\C-e": end-of-line'
bind '"\C-b": backward-char'
bind '"\C-f": forward-char'
bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\eOD": backward-word'
bind '"\eOC": forward-word'

bind '"\C-h": backward-delete-char'
bind '"\C-k": kill-line'
bind '"\C-u": unix-line-discard'
bind '"\C-w": unix-word-rubout'
bind '"\e\C-?": unix-word-rubout'

bind '"\e#": insert-comment'
bind '"\e*": insert-completions'

bind '"\C-_": undo'
bind '"\C-j": accept-line'
bind '"\C-o": operate-and-get-next'
bind '"\C-l": clear-screen'
bind '"\C-o": overwrite-mode'
bind '"\C-v": quoted-insert'
bind '"\C-x\C-e": edit-and-execute-command'
bind '"\C-x\C-k": "\C-e\C-u"' # push-line alternative
bind '"\C-xa": alias-expand-line'
bind '"\C-y": yank'
bind '"\e.": insert-last-argument'

bind '"\C-x\C-x" "\C-e\C-ukeybindings\n\C-y"'

bind '"\e[15~" "\C-e\C-u\C-p\C-j\C-y"'
bind '"\er" "\C-e\C-ur\n\C-y"'
bind '"\eu" "\C-e\C-ucd ..\n\C-y"'

bind '"\C-xr" "\C-e\C-uexec ${SHELLNAME:-$SHELL}\C-j\C-y"'

# git
bind '"\C-gd" "\C-e\C-ugit diff\C-j\C-y"'
bind '"\C-gl" "\C-e\C-ugit l\C-j\C-y"'
bind '"\C-gs" "\C-e\C-ugit st\C-j\C-y"'
