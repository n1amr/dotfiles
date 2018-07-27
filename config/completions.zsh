for file in "$DOTFILES_HOME/bin/completion"/*; do
    command="$(basename "$file")"

    # function _sync-ssh {
    #     reply=( $("$DOTFILES_HOME/bin/completion/sync-ssh") );
    # }
    # compctl -K _sync-ssh sync-ssh
    eval "function _$command () { reply=( \$(\"$DOTFILES_HOME/bin/completion/$command\") ); }; compctl -K \"_$command\" \"$command\""
done
