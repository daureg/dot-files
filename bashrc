# Check for an interactive session
[ -z "$PS1" ] && return

source ~/.bash_aliases
source /etc/profile
export EDITOR=/usr/bin/vim
export EMAIL="Géraud Le Falher <daureg@gmail.com>"
export GREP_OPTIONS="--exclude-dir=\.svn"
export GREP_COLOR="1;32"                    # green

# History file: (must haves for those that use the command line alot)
# Increase history file size,
# increase number of commands saved (default: 500),
# append commands instead of overwriting (nice for two or more sessions), 
# add command to history after executing,
# don't put duplicate lines in history, ignore same successive entries.
export HISTFILESIZE=20000
export HISTSIZE=5000
shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

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

# xhost +si:localuser:$(whoami)
export PS1="\
\e[0;32m\D{%a %d %b}\e[m |\
\e[1;32m \D{%T}\e[m |\
\e[1;35m \$(get_sysinfo uptime)\e[m |\
\e[0;36m \$(get_sysinfo disk_free ${DISTRO})\e[m |\
\e[1;36m \$(get_sysinfo mem_free)\e[m |\
\e[1;34m \W \e[m\n"
clear
#\e[1;31m \$(get_sysinfo cpu_temp)\e[m |\
