#! /bin/sh
mkdir -pv ~/.vim/templates
mkdir -pv ~/.vim/snippets
mkdir -pv ~/.vim/ftplugin
ln -svf templates/xetex ~/.vim/templates/xetex
ln -svf templates/python ~/.vim/templates/python
ln -svf templates/html ~/.vim/templates/html
ln -svf snippets/c-my.snippets ~/.vim/snippets/c-my.snippets
ln -svf snippets/tex-my.snippets ~/.vim/snippets/tex-my.snippets
ln -svf snippets/javascript-my.snippets ~/.vim/snippets/javascript-my.snippets
ln -svf snippets/scheme-my.snippets ~/.vim/snippets/scheme-my.snippets
ln -svf snippets/html-my.snippets ~/.vim/snippets/html-my.snippets
ln -svf python.vim ~/.vim/ftplugin/python.vim
ln -sfv gvimrc $HOME/.gvimrc
ln -sfv vimrc $HOME/.vimrc
ln -sfv xinitrc $HOME/.xinitrc
ln -sfv xserverrc $HOME/.xserverrc
ln -sfv bashrc $HOME/.bashrc
ln -sfv bash_profile $HOME/.bash_profile
ln -sfv bash_aliases $HOME/.bash_aliases
ln -sfv gitconfig $HOME/.gitconfig
ln -sfv valgrindrc $HOME/.valgrindrc
ln -sfv astylerc $HOME/.astylerc
ln -sfv pylintrc $HOME/.pylintrc
ln -sfv sshconfig $HOME/.ssh/config
