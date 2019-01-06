for completion_root in "$DOTFILES_HOME/bin/completion" "$DOTFILES_HOME/custom/bin/completion" "$DOTFILES_HOME/custom/env/$DOTFILES_ENV/bin/completion"; do
    [[ ! -d "$completion_root" ]] && continue
    for file in "$completion_root"/*; do
        [[ ! -x "$file" ]] && continue
        command="$(basename "$file")"

        # function _sync-ssh {
        #     reply=( $("$DOTFILES_HOME/bin/completion/sync-ssh") );
        # }
        # compctl -K _sync-ssh sync-ssh
        eval "function _$command () { reply=( \$(\"$completion_root/$command\") ); }; compctl -K \"_$command\" \"$command\""
    done
done
