# Check for an interactive session
[ -z "$PS1" ] && return
source ~/.bash_aliases
source /etc/profile
usermodmap=$HOME/.Xmodmap
if [ -f $usermodmap ]; then
xmodmap $usermodmap
fi
# disable bell
xset -b
export PATH=~/bin:~/.local/bin:$PATH:~/.local/share/coursier/bin

export EDITOR=nvim
export EMAIL="Géraud Le Falher <daureg@gmail.com>"
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
export HISTFILESIZE=50000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
export HISTCONTROL=ignoredups:ignoreboth:erasedups:ignorespace
export HISTFILE="${HOME}/.history/$(date -u +%Y_%m)"
## SANE HISTORY DEFAULTS ##
# Don't record some commands
export HISTIGNORE="&:[ ]*:bg:fg:cd:ls:exit:clear:j *:mocp:n:ll:..:"
# Useful timestamp format
HISTTIMEFORMAT='%F %T '


# don't reference undefined variable (it break auto completion)
#  set -o nounset
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

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind -m vi-insert "\C-p":history-search-backward

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
export PS1="\
\033]0;bash\007\
\e[0;32m\D{%a %d %b}\e[m |\
\e[1;32m \D{%T}\e[m |\
\e[1;35m \$(uptime | awk '{print \$3;}'|tr -d ',')\e[m |\
\e[1;36m \$(free -m|grep 'Mem:'| awk '{print \$7;}')Mo\e[m |\
\e[1;31m \$([[ -s /sys/class/thermal/thermal_zone0/temp ]] && cut -c-2 /sys/class/thermal/thermal_zone0/temp)°C\e[m |\
\e[1;33m \$(parse_git_branch)\e[m |\
\e[1;34m \W \e[m\n"

# \e[0;36m \$(df -BM|grep sda6| awk '{print \$4;}')\e[m |\
# export PS1="\
# \033]0;bash\007\
# \e[0;32m\d \D{%R}\e[m |\
# \e[1;34m \W \e[m\n❯ "
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.2

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber
# Update window size after every command
shopt -s checkwinsize

## SMARTER TAB-COMPLETION (Readline bindings) ##
# Perform file completion in a case insensitive fashion
# bind "set completion-ignore-case on"
# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"


## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working
# directory, in home and in the ~/projects folder
CDPATH="."

# The part below is quite specific to a specific computer
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
if grep -q Ubuntu /etc/issue ; then
export DISTRO="ubuntu";
else
export DISTRO="archlinux";
fi
xhost local:orphee > /dev/null
if [ -e /usr/share/terminfo/g/gnome-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
export TERM=gnome-256color
fi
BASE16_SHELL="$HOME/base16-shell/scripts/base16-mocha.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
eval "$(dircolors -b)"

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
# if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-ahh -- \C-j"'; fi
source /usr/share/autojump/autojump.bash

export BAT_THEME=DarkNeon
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(nvim {})+abort'"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash


# https://makandracards.com/makandra/72209-how-to-install-npm-packages-globally-without-sudo-on-linux
export NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
clear

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  source $(pyenv root)/completions/pyenv.bash
fi

eval "$(direnv hook bash)"
