# Check for an interactive session
[ -z "$PS1" ] && return
source ~/.bash_aliases
source /etc/profile
export PATH=~/bin/:~/.local/bin:$PATH
export EDITOR=vim
export EMAIL="Géraud Le Falher <daureg@gmail.com>"
export GREP_OPTIONS="--exclude-dir=\.svn"
export GREP_COLOR="1;32"                    # green
export PYTHONSTARTUP=~/.pythonrc
# http://www.catonmat.net/blog/bash-vi-editing-mode-cheat-sheet/ and man readline
set -o vi

# History file: (must haves for those that use the command line alot)
# Increase history file size,
# increase number of commands saved (default: 500),
# append commands instead of overwriting (nice for two or more sessions), 
# add command to history after executing,
# don't put duplicate lines in history, ignore same successive entries.
unset HISTFILESIZE
export HISTSIZE=50000
export HISTFILESIZE=10000
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups:ignoreboth:erasedups

# don't reference undefined variable
# set -o nounset
#extension
shopt -s cdspell # Pour que bash corrige automatiquement les fautes de frappes ex: cd ~/fiml sera remplacé par cd ~/film
#shopt -s checkwinsize # Pour que bash vérifie la taille de la fenêtre après chaque commande
shopt -s cmdhist # Pour que bash sauve dans l'historique les commandes qui prennent plusieurs lignes sur une seule ligne.
#shopt -s dotglob # Pour que bash montre les fichiers qui commencent par un .
#shopt -s expand_aliases # Pour que bash montre la commande complete au lieu de l'alias
#shopt -s extglob # Pour que bash, interprète les expressions génériques
#shopt -s hostcomplete # Pour que bash tente de résoudre le nom pour les ip suivis d'un @
#shopt -s nocaseglob # Pour que bash ne soit pas sensible a la casse
# Bash completion extended
set show-all-if-ambiguous on

# Less Colors for Man Pages
if [[ ${TERM} == "xterm" ]]; then
  export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # bold mode      - main      (cyan)
  export LESS_TERMCAP_us=$'\e[38;5;97m'     # underline mode - second    (purp)
  export LESS_TERMCAP_so=$'\e[38;5;252m'    # standout-mode  - info/find (gray)
  export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking - unused?   (red)
  export LESS_TERMCAP_ue=$'\e[0m'           # end underline
  export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
  export LESS_TERMCAP_me=$'\e[0m'           # end all mode        - txt rest
  else
  export LESS_TERMCAP_md=$'\e[01;34m'
  export LESS_TERMCAP_us=$'\e[01;35m'
  export LESS_TERMCAP_so=$'\e[01;30m'
  export LESS_TERMCAP_mb=$'\e[01;31m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_me=$'\e[0m'
fi

if grep -q Ubuntu /etc/issue ; then
	export DISTRO="ubuntu";
else
	export DISTRO="archlinux";
fi

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind -m vi-insert "\C-p":history-search-backward

# xhost +si:localuser:$(whoami)
export PS1="\
\e[0;32m\D{%a %d %b}\e[m |\
\e[1;32m \D{%T}\e[m |\
\e[1;35m \$(uptime | awk '{print \$3;}'|tr -d ',')\e[m |\
\e[0;36m \$(df -BM|grep sda9| awk '{print \$4;}')\e[m |\
\e[1;36m \$(free -m|grep 'cache:'| awk '{print \$4;}')Mo\e[m |\
\e[1;31m \$([[ -s /sys/class/thermal/thermal_zone0/temp ]] && cut -c-2 /sys/class/thermal/thermal_zone0/temp)°C\e[m |\
\e[1;34m \W \e[m\n"
[[ -s /etc/profile.d/autojump.bash ]] && . /etc/profile.d/autojump.bash
export GPODDER_HOME=/home/orphee/data/podcast
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
clear
