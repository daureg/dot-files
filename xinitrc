#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

SESSION=xfce

#aplay -q $HOME/.sounds/startup.wav &
# aplay -q $HOME/data/music/sarajevo.wav &
fbsetbg -a -r $HOME/data/wallpapers
numlockx on
setxkbmap fr oss
local SSH_ENV="$HOME/.ssh/environment"
/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
chmod 600 "$SSH_ENV"
. "$SSH_ENV" > /dev/null

# merge in defaults and keymaps
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi
if [ -f $userresources ]; then
	xrdb -merge $userresources
fi
if [ -f $usermodmap ]; then
	xmodmap $usermodmap
fi

function start_term() {
	exec  /usr/bin/xterm -name login -geometry 150x60+0+0 -C -fg black -bg white +sb -T "Console login"
}
function start_wmii() {
	exec  /usr/bin/wmii
}
function start_gnome() {
	exec  gnome-session
}
function start_xfce() {
	exec  startxfce4
}
function start_kde() {
	exec  startkde
}
function start_e17() {
	exec  /opt/e17/bin/enlightenment_start
}
function start_fluxbox() {
	exec  startfluxbox
}
function start_metisse() {
	Xmetisse -ac -geometry 1280x1024 :1 >& .Xmetisse-log &
	metisse-start-fvwm >& .compositor-log &
	xterm
	killall Xmetisse
}
function start_xmonad() {
	exec  xmonad
}
function start_awesome() {
	exec  /usr/bin/awesome
}
function start_e17() {
	exec  /usr/bin/enlightenment_start
}
function start_mate() {
	exec mate-session
}

# exec $1
case $SESSION in
	xfce) start_xfce ;;
	mate) start_mate ;;
	e17) start_e17 ;;
	gnome) start_gnome ;;
	fluxbox) start_fluxbox ;;
	term) start_term ;;
	e17) start_e17 ;;
	kde4-svn) start_kde4 ;;
	wmii) start_wmii ;;
	awesome) start_awesome ;;
	metisse) start_metisse ;;
	xmonad) start_xmonad ;;
	*) start_xfce ;;
esac
