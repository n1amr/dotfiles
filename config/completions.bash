__dotfiles_bash_complete () {
    local completion_command=''
    local completion_root
    local result

    for completion_root in "$DOTFILES_HOME/bin/completion" "$DOTFILES_HOME/custom/bin/completion" "$DOTFILES_HOME/custom/env/$DOTFILES_ENV/bin/completion"; do
        if [ -x "$completion_root/${COMP_WORDS[0]}" ]; then
            completion_command="$completion_root/${COMP_WORDS[0]}"
        fi
    done

    [ -z "$completion_command" ] && return

    COMPREPLY=()
    while IFS= read -r result; do
        if [ -z "$2" ] || [[ "$result" = "$2"* ]]; then
            COMPREPLY[${#COMPREPLY[@]}]="$result"
        fi
    done < <("$completion_command")
}

for completion_root in "$DOTFILES_HOME/bin/completion" "$DOTFILES_HOME/custom/bin/completion" "$DOTFILES_HOME/custom/env/$DOTFILES_ENV/bin/completion"; do
    [[ ! -d "$completion_root" ]] && continue
    for file in "$completion_root"/*; do
        [[ ! -x "$file" ]] && continue
        command="$(basename "$file")"
        complete -F __dotfiles_bash_complete "$command"
    done
done
