##################################################
# Environment variables
##################################################

export N1AMR_HOME='/home/n1amr'
export NAME='Amr Alaa'
export EMAIL='n1amr1@gmail.com'
export DDNS='n1amr.ddns.net'

if [ -f ~/.keys ]; then
    . ~/.keys
fi

export D='/mnt/Storage'
export GDRIVE="$D/GoogleDrive"

export EDITOR='vim'
export VISUAL="$EDITOR"

##################################################
# PATH
##################################################

export PATH="/usr/bin/:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$N1AMR_HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$N1AMR_HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export GOPATH="$N1AMR_HOME/.gopath"
export PATH="$GOPATH/bin:$PATH"
export PATH="$N1AMR_HOME/.local/bin:$PATH"

##################################################
# Functions
##################################################

print_welcome () {
	if [[ $(( $COLUMNS > 98 )) == 1 ]]; then
		echo -e "\e[1;31m         _                               _   \e[1;34m                  _                                _  \e[m";
		echo -e "\e[1;31m  _ __  / |  __ _  _ __ ___   _ __  _   | |  \e[1;34m __      __  ___ | |  ___   ___   _ __ ___    ___ | | \e[m";
		echo -e "\e[1;31m | '_  \| | / _\` || '_ \` _  \| '__|(_) / __) \e[1;34m \ \ /\ / / / _ \| | / __| / _ \ | '_ \` _  \ / _ \| | \e[m";
		echo -e "\e[1;31m | | | || || (_| || | | | | || |    _  \__ \ \e[1;34m  \ V  V / |  __/| || (__ | (_) || | | | | ||  __/|_| \e[m";
		echo -e "\e[1;31m |_| |_||_| \__,_||_| |_| |_||_|   (_) (   / \e[1;34m   \_/\_/   \___||_| \___| \___/ |_| |_| |_| \___|(_) \e[m";
		echo -e "\e[1;31m                                        |_|  \e[1;34m                                                      \e[m";
	fi
}

print_upgradable_pkgs() {
	pkgs=($(apt list --upgradable 2> /dev/null | cut -d '/' -f 1))
	if [[ ${#pkgs[@]} > 1 ]]; then
		echo -en '\e[0;32mUpgradable Packages: \e[m'
		for pkg_name in ${pkgs[@]:1}; do
			echo -n "$pkg_name "
		done
		echo
	fi
}

backup () {
    cp "$1" "$1.bak";
}

findword () {
    grep -P "$1" /usr/share/dict/words;
}

# A rainbow in your shell.
rainbow () {
    yes "$(seq 231 -1 16)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done
}

hcd () {
    history | grep -P "\d+\s+cd $@";
}

terminal_rezise () {
    eval `/usr/bin/resize`;
}

__git_ps1_branch () {
    git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/ (\1)/';
}

##################################################
# Aliases
##################################################

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'
alias beep='paplay /home/n1amr/.local/Schedule.ogg'
alias brc='subl ~/.bashrc'
alias clock='tty-clock -scn -C 2'
alias clr='clear'
alias cp='cp -i'
alias f='find | grep -P'
alias fgrep='grep -F'
alias g='grep'
alias gdplshared='drive pull -ignore-name-clashes'
alias gitnext="git checkout \`git log --reverse --ancestry-path HEAD..master --oneline | head -1 | awk '{print \$1}'\`"
alias gitprev='git checkout HEAD~'
alias grepp='grep -P --color=auto'
alias h='history'
alias l='ls -lgoh'
alias matlab-cli='DISPLAY='' matlab'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias myip='wget http://ipinfo.io/ip -qO -'
alias nmcli='nmcli -a'
alias o='gnome-open'
alias ojar='java -jar'
alias oo='nautilus --browser .'
alias pg='grep -P --color=auto'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias pss='ps -e lx'
alias py='python -c'
alias rb='ruby -e'
alias rbox='rhythmbox-client'
alias rm='rm -i'
alias s='subl'
alias ss='subl .'
alias sshot='screenshot-nicename /mnt/Storage/Pictures/Screenshots/*from*'
alias tf='tail -f'
alias tm='nohup terminator & exit'
alias tr='trash -v'
alias v='vim'
alias vi='vim'
alias wget='wget -c'

##################################################
# PS1 create
##################################################

reset_ps1(){
	ps1_com(){
		echo -e " ";
	}
}
reset_ps1

export PS1='\[\e[1;31m\]\u@\H\[\e[m\]:\[\e[1;34m\]\w\[\e[1;35m\]$(__git_ps1_branch) \[\e[1;33m\]$(ps1_com)\n \[\e[0;32m\]$ \[\e[m\]'

# C_BLACK='\e[0;30m'
# C_RED='\e[0;31m'
# C_GREEN='\e[0;32m'
# C_YELLOW='\e[0;33m'
# C_BLUE='\e[0;34m'
# C_PURPLE='\e[0;35m'
# C_CYAN='\e[0;36m'
# C_WHITE='\e[0;37m'
# C_BOLD_RED='\e[1;31m'
# C_BOLD_YELLOW='\e[1;33m'
# C_BOLD_BLUE='\e[1;34m'
# C_BOLD_PURPLE='\e[1;35m'
# C_DARK_GREEN='\e[2;32m'
# C_RESET='\e[m'
# export PS1="${C_RESET}${debian_chroot:+($debian_chroot)}${C_BOLD_RED}\u@\H${C_RESET}:${C_BOLD_BLUE}\w${C_BOLD_PURPLE}\$(__git_ps1_branch) ${C_BOLD_YELLOW}\$(ps1_com)\n ${C_GREEN}\$${C_RESET} "

##################################################
# Other
##################################################

shopt -s autocd
shopt -s globstar

# terminal_rezise;
print_welcome
