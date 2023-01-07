# vim: ft=fish
alias lg="xfce4-session-logout --suspend"
alias mpv="LD_LIBRARY_PATH=$HOME/lib /usr/bin/mpv"
alias wget='wget -c'
alias dw='aria2c -x2 $(xclip -o)'
alias s3dw='aws s3 cp $(xclip -selection clipboard -o) .'
alias ydw='yt-dlp -f 136+140 $(xclip -selection clipboard -o| cut -d "=" -f2)'
alias n='nvim -i ~/.local/share/nvim/shada/main.shada'
alias c='clear -x'
alias s3ls='aws s3 ls --human-readable'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias g=rg
alias pg='rg -t py'
alias d='colordiff -Naurp'
# safety features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias sduo=sudo
alias llt='ls -larht --color=auto | tail'

alias gts="git status"
alias gtc="git commit"
alias gtd="git diff"
alias gtl='git log --date=short --pretty=format:"%cd %s"'
alias gtll='git log --graph --stat --pretty=format:"%ar: %s (%an)"'
alias p=python3

alias cpb='black -t py39 -l 88'
alias cpi='reorder-python-imports --py39-plus'
alias cpl='flake8 --config ~/work/boost/model-builder/setup.cfg'
alias cpm='mypy --strict'
alias cpu="pyupgrade --py39-plus"
alias cpt='pytype --strict-import --use-enum-overlay -V 3.9'
alias gg="/opt/google/chrome/google-chrome"
alias scas="pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo"
alias senc="pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo"
alias pu="pip install -U --upgrade-strategy=eager"

function ns3
    set T $(mktemp)
    aws s3 cp $(xclip -selection clipboard -o) $T
    nvim $T
    rm $T
end

function s3cat -a U
    set T $(mktemp)
    aws s3 cp $U $T
    cat $T
    rm $T
end

function fts -a S
    sed -i "/FontName/s/[[:digit:]]\+/$S/" $HOME/.config/xfce4/terminal/terminalrc
end

function dbjob -a J
    set run_id $(databricks runs submit --json-file $J |jq .run_id)
    set jurl $(databricks runs get --run-id $run_id | jq .run_page_url | sed 's,#,/#,g' | sed 's,",,g')
    echo $jurl
    xdg-open $jurl
end

function dbstat -a A
    databricks runs get --run-id $A |jq '(.start_time |= (. / 1000 | strftime("%Y-%m-%d %H:%M:%S")) ) | {start_time, status: .state.life_cycle_state, run_page_url}'
end

function tgz
    set A $(basename $argv[1])
    time tar caf $A.tar.gz $A
end

function his
    rg -Ia "$argv" $HOME/.history/* $HOME/.local/share/fish/20*_history | sed -e 's/^- cmd: //' |sort|uniq
end

function rsize -a U
    curl -sLI $U |grep -i length|cut -d ' ' -f2
end

function wiki_note
    pushd ~/work/boost/wiki
    $EDITOR -c "set spelllang=en spell cole=0 linebreak tw=0 ts=4 sw=4 et" -c "MarkdownPreview" $(whoami)_$(date +"%Y%m%d_%H%M").md
    git status
end

set -u fish_history $(date -u +%Y_%m)

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
end
bind -M insert \e\[A history-prefix-search-backward
bind -M insert \e\[B history-prefix-search-forward
direnv hook fish | source
set PATH $PATH:/usr/local/go/bin
xmodmap -e 'keycode 133 =  less greater less greater lessthanequal greaterthanequal lessthanequal greaterthanequal'
source ~/.pyenv/completions/pyenv.fish
