alias ls='ls --color=auto'
alias ll='ls -larht --color=auto'
alias g='grep --color=auto'
alias pu='sudo pacman -U'
alias ct='clear && time'
alias mpkg='ct makepkg -L'
alias rpkg='rm -rf pkg/ src/ *tar* *zip* *.log* svn_log'
alias x="startx"
alias pc='yes "o" | sudo pacman -Scc'
alias sduo=sudo
alias rst='sudo reboot'
alias stop='sudo shutdown -h now'
alias pclm='pkg-config --cflags --libs --modversion'
alias sv='sudo vim'
alias less=/usr/share/vim/vim72/macros/less.sh
alias gts="git status"
alias gtc="git commit"
alias d='colordiff -Naur'
alias gtl='git log --date=short --pretty=format:"%cd %s"'
alias svx='cp /etc/X11/xorg.conf ~/data/x11/xorg.conf.`date +"%Y-%m-%d-%H-%M-%S"`'
getpkg() {
	ct svn co svn://svn.archlinux.org/srv/svn-packages/$1/trunk $1
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
	echo $RANDOM > .KEEPITALIVE
	if [ $DAY -eq 7 ]
	then
		echo "FTP :"
		lftp -e "put .KEEPITALIVE && exit" -u daureg ftpperso.free.fr
		sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
		sudo update-desktop-database /usr/share/applications
		echo "Mise à jour des paquets"
		time yaourt -Syu --aur
	else
		echo "Mise à jour des paquets"
		time sudo pacman -Syu 
	fi
	rm .KEEPITALIVE
}

save_all() {
	echo "Verifiez que vous avez nettoyé data et devel avant"
	read anykey
	cd $HOME
	save_pkg
	mkdir .conf
	cp -r .bash* .gvimrc .vim* .xinitrc .conf
	tar caf pkg.tar.lzma .pkg 
	tar caf data.tar.lzma d/data
	tar caf devel.tar.lzma d/devel
	tar caf music.tar d/music
	gzip --fast music.tar
	tar caf conf.tar.lzma .conf
	sudo tar caf etc.tar.lzma /etc
	echo "NON COMPLET, Dépécher vous de le copier quelque part"
}

hgl() {
	hg pull > .pete__ && hg update
	N=`grep with .pete__ |cut -c7-|cut -d ' ' -f1`
	hg log -l $N |grep summ|cut -c14-|less
}
# vim: ft=sh
