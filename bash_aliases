# vim: ft=sh
# find /usr/lib/ghc-7.6.3/site-local/ -name *_p.a -exec du '{}' \;|sort -n
# pacman -Ql haskell-pandoc | cut -d ' ' -f2| grep -v "\/$"|xargs du|sort -n|tail
# Coreutils
alias mm='sudo mount -v /dev/sdb ~/fs/key'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls --color=auto'
alias ll='ls -larht --color=auto'
alias g='grep --color=auto'
alias ct='clear && time'
alias d='colordiff -Naurp'
alias mkdir='mkdir -pv'
alias ping='ping -c 5'
alias hist='history | grep'
alias openports='netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep'
# privileged access
if [ $UID -ne 0 ]; then
    alias scat='sudo cat'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
fi
# safety features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# sudo
alias sduo=sudo
alias rst='sudo reboot'
alias stop='sudo shutdown -h now'
alias sv='sudo vim'

# pacman
alias pacman='pacman'
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
alias x=startx
alias svx='cp /etc/X11/xorg.conf ~/data/x11/xorg.conf.`date +"%Y-%m-%d-%H-%M-%S"`'

# git
alias gts="git status"
alias gtc="git commit"
alias gtd="git diff"
alias gtl='git log --date=short --pretty=format:"%cd %s"'
#GiT Long Log
alias gtll='git log --graph --stat --pretty=format:"%ar: %s (%an)"'
alias gssh=start_ssh

# Misc
alias gram='java -jar ~/LT/languagetool-commandline.jar -l en-US'
alias gramf='java -jar ~/LT/languagetool-commandline.jar -l fr'
alias pclm='pkg-config --modversion'
alias serv='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
if [ -e /usr/share/vim/vim74/macros/less.sh ]; then
alias less=/usr/share/vim/vim74/macros/less.sh
fi
alias m="vim mail.nv"
alias p=python
alias p2=python2
alias cltex="rm -f *.{acn,acr,alg,aux,bbl,bcf,blg,dvi,fdb_latexmk,fls,glg,glo,gls,idx,ilg,ind,ist,lof,log,lot,maf,mtc,mtc0,nav,nlo,out,pdfsync,ps,run.xml,snm,synctex.gz,toc,vrb,xdy,tdo}"

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
sopcast() {
	sp-sc $1 3908 8908 > /dev/null &
	vlc http://localhost:8908/tv.asf &
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
	tar caf data.tar.lzma data/
	tar caf devel.tar.lzma devel/
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
spl() {
	hunspell -d fr_FR -l $1 | grep -v "^-"|sort|uniq
}
bench3d() {
	lspci | grep VGA | colrm 1 4
	cat /proc/cpuinfo | grep "model name\|MHz"
	xdpyinfo | grep "version:\|dimensions\|depth of"
	glxinfo | grep -A2 "direct rendering\|OpenGL vendor"
	glxgears & sleep 26
	killall glxgears
}
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
        *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
               c='bsdtar xvf';;
        *.7z)  c='7z x';;
        *.Z)   c='uncompress';;
        *.bz2) c='bunzip2';;
        *.exe) c='cabextract';;
        *.gz)  c='gunzip';;
        *.rar) c='unrar x';;
        *.xz)  c='unxz';;
        *.zip) c='unzip';;
        *)     echo "$0: unrecognized file extension: \`$i'" >&2
               continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}
#count words
cw() {
	cat $1 |tr A-Z a-z|tr ' ' '\n'| tr -d "?!.;,…0-9'"|sort|uniq -c|sort -n
}
videort() {
	pushd ~/fs/D/videos
	rm -f ddur
	for i in *.{avi,webm,mp4}
	do
		DUR=$(ffprobe $i 2>&1 | grep 'Duration' | awk '{print $2}'|cut -d '.' -f1);
		echo $DUR $i >> ddur;
	done
	sort ddur -o ddur
	popd
}
tmongo() {
	ssh triton -N -L 27113:triton.aalto.fi:27133 -f
	ssh triton -N -L 28113:triton.aalto.fi:28133 -f
	cd ~/flitest
}
