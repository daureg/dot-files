# Check for an interactive session
[ -z "$PS1" ] && return
export EDITOR=/usr/bin/vim
#export VISUAL=/usr/bin/gvim
export EMAIL="Géraud Le Falher <daureg@gmail.com>"
source ~/.bash_aliases
source /etc/bash_completion
source /etc/profile
source /etc/profile.d/autojump.bash
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
export PS1="\
\e[0;32m\D{%a %d %b}\e[m |\
\e[1;32m \D{%T}\e[m |\
\e[1;35m \$(get_sysinfo uptime)\e[m |\
\e[1;31m \$(get_sysinfo cpu_temp)\e[m |\
\e[0;36m \$(get_sysinfo disk_free)\e[m |\
\e[1;36m \$(get_sysinfo mem_free)\e[m |\
\e[1;34m \W \e[m\n"
clear
