# vim: ft=fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    uv generate-shell-completion fish | source
end

alias zlaude='rm -rf ~/.claude/statsig && CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1 claude'
alias lg="xfce4-session-logout --suspend"
alias wget='wget -c'
alias dw='aria2c -x2 $(xclip -o)'
alias s3dw='aws s3 cp $(xclip -selection clipboard -o) .'
alias n='nvim -i ~/.local/share/nvim/shada/main.shada'
alias nn='NVIM_APPNAME="nvim-chad" nvim'
alias c='clear -x'
alias s3ls='aws s3 ls --human-readable'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias dpi='xfconf-query -c xsettings -p /Xft/DPI -s'
alias ccusage="deno run -E --allow-read -S=homedir -N='raw.githubusercontent.com:443' npm:ccusage@latest --offline"
alias cal='ncal -Mw3'

# https://fishshell.com/docs/3.6/relnotes.html#notable-improvements-and-fixes
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd
# https://fishshell.com/docs/current/cmds/abbr.html#examples
function vim_edit
    echo nvim $argv
end
abbr -a vim_edit_texts --position command --regex ".+\.md" --function vim_edit
function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

alias uvr='uv run --index https://pypi.org/simple'
alias fmpv='mpv -fs --speed=1.4'
alias gpro='zllm -m "gemini/gemini-2.5-pro"'
alias gpt='zllm -m "openai/gpt-5.1"'
alias rdns='sudo resolvectl dns wlp3s0 1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com && sleep 1 && sudo systemctl restart NetworkManager && sleep 1 && sudo systemctl restart systemd-networkd && sleep 1 && sudo systemctl restart systemd-resolved && sleep 1 && sudo cp ~/default_resolv.conf /etc/resolv.conf'
alias csp='cat ~/work/boost/example_s3_path'
alias g=rg
alias pg='rg -t py'
alias d='colordiff -Naurp'
# safety features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias sduo=sudo
alias llt='ls -larht --color=auto | tail'

alias wpr="gh pr view --web"
alias wrp="gh repo view --web"
alias gts="git status"
alias gtc="git commit"
alias gtd="git diff"
alias gtl='git log --date=short --pretty=format:"%cd %s"'
alias gtll='git log --graph --stat --pretty=format:"%ar: %s (%an)"'
alias p=python3
alias pclean='fd -t f -uu -H pyc -X rm && fd -0 -t d -uu __pycache__ -X rmdir'

alias cpm='mypy --strict'
alias gg="google-chrome"
alias scas="pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo"
alias senc="pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo"
alias ca='zalando-aws-cli account-access request search'
alias 204='curl --write-out "%{http_code}" http://google.com/generate_204'
alias sb='clc in --interactive=0 --project boost'
alias zb='clc in --interactive=0 --project boost --description zonar'
alias eb='clc out'
alias rfc='ruff check --config ~/.config/ruff/pyproject.toml --fix'
alias rff='ruff format --config ~/.config/ruff/pyproject.toml'
alias sdb='databricks clusters start --no-wait 0113-113248-3x97ftvw'

function git_pr_sum -a N
    git log -n $N  --format=format:"%h %s%n%b" --reverse main..
end

function cfr -a R
    ruff check --config ~/.config/ruff/pyproject.toml --fix $R || ruff format --config ~/.config/ruff/pyproject.toml $R
end

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

# function fts -a S
#     sed -i "/FontName/s/[[:digit:]]\+/$S/" $HOME/.config/xfce4/terminal/terminalrc
# end
function fts -a S
    xfconf-query -c xfce4-terminal -p /font-name -s "RecMonoDuotone Nerd Font Mono Regular $S"
end

function dbjob -a J
    set run_id $(databricks jobs submit --no-wait --json @$J |jq .run_id)
    set jurl $(databricks jobs get-run $run_id | jq .run_page_url | sed 's,#,/#,g' | sed 's,",,g')
    echo $jurl
    xdg-open $jurl
end

function diffco -a C
    git diff $C^..$C
end

function ydw -a U
    set SU $(xclip -selection clipboard -o| string match -r 'watch\?v=([a-zA-Z0-9_-]+).*' | tail -n1)
    yt-dlp  $SU
end
function dbstat -a A
    databricks jobs get-run $A |jq '(.start_time |= (. / 1000 | strftime("%Y-%m-%d %H:%M:%S")) ) | {start_time, status: .state.life_cycle_state, run_page_url}'
end

function tgz
    set A $(basename $argv[1])
    time tar caf $A.tar.gz $A
end
function his
    rg -Ia "$argv" $HOME/.history/* $HOME/.local/share/fish/20*_history | g -v '  when: 16' | sed -e 's/^- cmd: //' |sort|uniq
end
function rhis
    rg -Ia "$argv" $(fd --changed-within 3months hist ~/.local/share/fish/) | g -v '  when: 16' | sed -e 's/^- cmd: //' |sort|uniq
end

function rsize -a U
    curl -sLI $U |grep -i length|cut -d ' ' -f2
end

function wiki_note
    pushd ~/work/boost/wiki
    $EDITOR -c "set spelllang=en spell cole=0 linebreak tw=0 ts=2 sw=2 et" -c "MarkdownPreview" $(whoami)_$(date +"%Y%m%d_%H%M").md
    git status
end

function bpr
    gh api -X GET --paginate --hostname=github.bus.zalan.do search/issues \
          -f q='is:pr is:open org:boost archived:false' \
          | jq -r '.total_count, .items[].html_url'
end

function nb -a B
    git switch -c $B
end

function upawscli
    aws --version
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    ./aws/install --bin-dir $HOME/.local/bin --install-dir ~/.local/aws-cli --update
    rm -rf awscliv2.zip aws/
    aws --version
end

function ipush
    set B $(git symbolic-ref --short HEAD)
    git push -u origin $B
end

function gp
    set B $(git symbolic-ref --short HEAD)
    git push origin $B
end
function gpf
    set B $(git symbolic-ref --short HEAD)
    git push --force-with-lease --force-if-includes origin $B
end
function get_nb -a path
    databricks workspace export "$path"
end

function dwy
    set U $(xclip -sel clipboard -o)
    set I $(string split -rm1 -f2 "=" $U)
    yt-dlp $I
end

set -u fish_history $(date -u +%Y_%m)

bind --mode insert \e\[A 'history-prefix-search-backward'
bind --mode insert \e\[B 'history-prefix-search-forward'
# xmodmap -e 'keycode 133 =  less greater less greater lessthanequal greaterthanequal lessthanequal greaterthanequal'

# https://github.com/rkitover/vimpager
set PAGER /usr/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

# https://blog.packagecloud.io/set-environment-variable-save-thousands-of-system-calls/
# https://news.ycombinator.com/item?id=13697555
# WARNING:tzlocal:/etc/timezone is deprecated in some distros, and no longer reliable. tzlocal is ignoring it, and you can likely delete it
# set TZ ":/etc/localtime"
export | egrep "DBUS_SESSION_BUS_ADDRESS|DISPLAY" | sed -e 's/ /="/'|sed -e 's/$/"/'|sed -e 's/^/export /' > ~/.xsession-export

set -x DO_NOT_TRACK 1
set -x HF_HUB_DISABLE_TELEMETRY 1
set -x HF_HUB_ENABLE_HF_TRANSFER 0

set -U fish_greeting
