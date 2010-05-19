# Coreutils
alias ls='ls --color=auto'
alias ll='ls -larht --color=auto'
alias g='grep --color=auto'
alias ct='clear && time'
alias d='colordiff -Naurp'

# sudo
alias sduo=sudo
alias rst='sudo reboot'
alias stop='sudo shutdown -h now'
alias sv='sudo vim'

# pacman
alias pc='yes "o" | sudo pacman -Scc'
alias pu='sudo pacman -U'
alias pd='sudo pacman -Rns'
alias pdd='sudo pacman -Rdns'
alias mpkg='ct makepkg -L'
alias rpkg='rm -rf pkg/ src/ *tar* *zip* *.log* svn_log'

# apt-get
alias aptc='sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean'
alias aptu='sudo apt-get install'
alias aptd='sudo apt-get remove --purge'

# Xorg
alias x="startx"
alias svx='cp /etc/X11/xorg.conf ~/data/x11/xorg.conf.`date +"%Y-%m-%d-%H-%M-%S"`'

# git
alias gts="git status"
alias gtc="git commit"
alias gtl='git log --date=short --pretty=format:"%cd %s"'
alias gssh=start_ssh

# Misc
alias pclm='pkg-config --cflags --libs --modversion'
alias less=/usr/share/vim/vim72/macros/less.sh

getpkg() {
	time svn co svn://svn.archlinux.org/packages/$1/trunk $1
	time svn co svn://svn.archlinux.org/community/$1/trunk $1
}

tbz() {
	time tar caf `basename $1`.tar.bz2 `basename $1`
}
tgz() {
	time tar caf `basename $1`.tar.gz `basename $1`
}
tlz() {
	time tar caf `basename $1`.tar.lzma `basename $1`
}

uparch() {
	local DAY=`date +%u`
	if [ $DAY -eq 7 ]
	then
		echo $RANDOM > .KEEPITALIVE
		echo "FTP :"
		lftp -e "put .KEEPITALIVE && exit" -u daureg ftpperso.free.fr
		rm .KEEPITALIVE

		sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
		sudo update-desktop-database /usr/share/applications

		echo "Mise à jour des paquets"
		time yaourt -Syu --aur
	else
		echo "Mise à jour des paquets"
		time sudo pacman -Syu 
	fi
}

ubuntu_up() {
	local DAY=`date +%u`
	if [ $DAY -eq 7 ]
	then
		echo $RANDOM > .KEEPITALIVE
		echo "FTP :"
		lftp -e "put .KEEPITALIVE && exit" -u daureg ftpperso.free.fr
		rm .KEEPITALIVE

		sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
		sudo update-desktop-database /usr/share/applications
	fi

		echo "Mise à jour des paquets"
		time sudo apt-get update
		time sudo apt-get upgrade
}

save_all() {
	echo "Verifiez que vous avez nettoyé data et devel avant"
	read anykey
	cd $HOME
	save_pkg
	tar caf pkg.tar.lzma .pkg 
	tar caf data.tar.lzma d/data
	tar caf devel.tar.lzma d/devel
	sudo tar caf etc.tar.lzma /etc
	echo "NON COMPLET, Dépécher vous de le copier quelque part"
}

hgl() {
	hg pull > .pete__ 
	hg update
	N=`grep with .pete__ |cut -c7-|cut -d ' ' -f1`
	hg log -l $N |grep summ|cut -c14-|less
	rm .pete__
}

start_ssh() {
	local SSH_ENV="$HOME/.ssh/environment"
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
	chmod 600 "$SSH_ENV"
	. "$SSH_ENV" > /dev/null
	/usr/bin/ssh-add
}

bench3d() {
	lspci | grep VGA | colrm 1 4
	cat /proc/cpuinfo | grep "model name\|MHz"
	xdpyinfo | grep "version:\|dimensions\|depth of"
	glxinfo | grep -A2 "direct rendering\|OpenGL vendor"
	glxgears & sleep 26
	killall glxgears
}
# vim: ft=sh
