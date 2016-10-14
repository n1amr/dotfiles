SHELLNAME=bash
export MY_SCRIPTS_ROOT="/home/n1amr/.local/bin"
if [ -f "$MY_SCRIPTS_ROOT/shellrc" ]; then
    . "$MY_SCRIPTS_ROOT/shellrc"
fi
