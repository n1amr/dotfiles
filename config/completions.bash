__bash_prefix_filter () {
    prefix="$1"
    shift
    results=()
    for arg in "$@"; do
        if [ -z "$prefix" ] || [[ "$arg" = "$prefix"* ]]; then
            results+=("$arg")
        fi
    done

    echo "${results[@]}"
}

for file in "$DOTFILES_HOME/bin/completion"/*; do
    command="$(basename "$file")"

    # function _sync-ssh {
    #     COMPREPLY=( $(__bash_prefix_filter "$2" $("$DOTFILES_HOME/bin/completion/sync-ssh")) );
    # }
    # 
    # complete -F _sync-ssh sync-ssh
    eval "function _$command () { COMPREPLY=( \$(__bash_prefix_filter \"\$2\" \$(\"$DOTFILES_HOME/bin/completion/$command\") ) ); }; complete -F \"_$command\" \"$command\""
done
