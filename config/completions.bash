__bash_prefix_filter () {
    prefix="$1"
    shift
    for arg in "$@"; do
        if [ -z "$prefix" ] || [[ "$arg" = "$prefix"* ]]; then
            if [[ "$arg" == *['!'@#\$%^\&*()_+\ \"\']* ]]; then
                echo "'$(<<<"$arg" sed "s/'/'\\\\''/g")'" #||
            else
                echo "$arg"
            fi
        fi
    done
}

for completion_root in "$DOTFILES_HOME/bin/completion" "$DOTFILES_HOME/custom/bin/completion" "$DOTFILES_HOME/custom/env/$DOTFILES_ENV/bin/completion"; do
    [[ ! -d "$completion_root" ]] && continue
    for file in "$completion_root"/*; do
        [[ ! -x "$file" ]] && continue
        command="$(basename "$file")"

        # function _sync-ssh {
        #     COMPREPLY=( $(__bash_prefix_filter "$2" $("$DOTFILES_HOME/bin/completion/sync-ssh")) );
        # }
        #
        # complete -F _sync-ssh sync-ssh
        eval "function _$command () { IFS=\$'\\r\\n' GLOBIGNORE='*' eval 'COMPREPLY=( \$(__bash_prefix_filter \"\$2\" \$(\"$completion_root/$command\") ) )'; }; complete -F \"_$command\" \"$command\""
    done
done
