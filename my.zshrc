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

export ANDROID_HOME="$D/ubuntu/usr/local/android-sdk"

##################################################
# PATH
##################################################

export PATH="/usr/bin/:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$N1AMR_HOME/.rbenv/bin:$PATH"
eval "$( [[ $(whence -f rbenv) ]] && rbenv init -)"
export PATH="$N1AMR_HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$N1AMR_HOME/.pyenv/bin:$PATH"
eval "$( [[ $(whence -f pyenv) ]] && pyenv init -)"
export GOPATH="$N1AMR_HOME/.gopath"
export PATH="$GOPATH/bin:$PATH"
export PATH="$N1AMR_HOME/.local/bin:$PATH"

##################################################
# Functions
##################################################

print_welcome () {
	if [[ "$COLUMNS" -gt "98" ]]; then
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
alias c='clr'
alias clock='tty-clock -scn -C 2'
alias clr='clear'
alias cp='cp -i'
alias f='find | grep -P'
alias fgrep='grep -F'
alias g='grep'
alias gdplshared='drive pull -ignore-name-clashes'
alias gitnext="git checkout \`git log --reverse --ancestry-path HEAD..master --oneline | head -1 | awk '{print \$1}'\`"
alias gitprev='git checkout HEAD~'
alias gp='grep -P --color=auto'
alias h='history'
#alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias ipy="ipython"
alias j='jump'
alias l='ls -lgoh'
alias m='mark'
alias matlab-cli='DISPLAY='' matlab'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias myip='wget http://ipinfo.io/ip -qO -'
alias nmcli='nmcli -a'
alias o='gnome-open'
alias oo='nautilus --browser . &'
alias privateend='yes|cp ~/.zsh_history.bak ~/.zsh_history; for i in {0..10000}; do echo; done; /usr/bin/clear; exec zsh'
alias privatestart='yes|cp ~/.zsh_history ~/.zsh_history.bak;'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias pss='ps -e lx'
alias py='python -c'
alias qcommit='git add -A && git commit -m "$(date)"'
alias rb='ruby -e'
alias rm='rm -i'
alias s='subl'
alias ss='subl .'
alias sshot='screenshot-nicename /mnt/Storage/Pictures/Screenshots/*from*'
alias tf='tail -f'
alias tm='nohup terminator & exit'
alias tr='trash -v'
alias twitter='/home/n1amr/.rbenv/shims/t'
alias u='cd ..'
alias v='vim'
alias vi='vim'
alias wget='wget -c'

##################################################
# PS1 create
##################################################

reset_ps1() {
	# local C_BLACK='\e[0;30m'
	# local C_RED='\e[0;31m'
	# local C_GREEN='\e[0;32m'
	# local C_YELLOW='\e[0;33m'
	# local C_BLUE='\e[0;34m'
	# local C_PURPLE='\e[0;35m'
	# local C_CYAN='\e[0;36m'
	# local C_WHITE='\e[0;37m'
	# local C_BOLD_RED='\e[1;31m'
	# local C_BOLD_YELLOW='\e[1;33m'
	# local C_BOLD_BLUE='\e[1;34m'
	# local C_BOLD_MAGNETA='\e[1;35m'
	# local C_DARK_GREEN='\e[2;32m'
	# local C_RESET='\e[0m'
	# export PS1="${C_RESET}${debian_chroot:+($debian_chroot) }${C_BOLD_RED}\u@\H${C_RESET}:${C_BOLD_BLUE}\w${C_BOLD_MAGNETA}\$(__git_ps1_branch) ${C_BOLD_YELLOW}\$(ps1_eval)\n ${C_GREEN}\$ ${C_RESET}"

	# export PS1=$'%{\e[0m%}${debian_chroot:+($debian_chroot) }%{\e[1;31m%}%n@%M%{\e[0m%}:%{\e[1;34m%}%/%{\e[1;35m%}\$(__git_ps1_branch) %{\e[1;33m%}\$(ps1_eval)
	export PS1=$'%{\e[0m%}${debian_chroot:+($debian_chroot) }%{\e[1;31m%}%n@%M%{\e[0m%}:%{\e[1;34m%}%~%{\e[1;35m%}\$(__git_ps1_branch) %{\e[1;33m%}\$(ps1_eval)
 %{\e[0;32m%}$ %{\e[0m%}'

	ps1_reset
}

# PS1 extention
ps1_eval(){ [[ $(whence -f ps1_command) ]] && echo -e "[$(ps1_command)]"; }

ps1_reset(){ [[ $(whence -f ps1_command) ]] && unset -f ps1_command; }

ps1_time() {
	ps1_command() { date +%T; }
}

ps1_words() {
	ps1_command() { shuf '/mnt/Storage/Documents/Reader/Languages/English/English Words/all-words.txt' | head -1; }
}

ps1_all_words() {
	ps1_command() { shuf /usr/share/dict/words | head -1; }
}

ps1_memory() {
	ps1_command() { free -m | head -2 | tail -1 | awk '{printf "%d/%d\n", $3, $2}'; }
}

##################################################
# Other
##################################################

terminal_rezise
print_welcome
reset_ps1
