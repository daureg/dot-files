#! /bin/sh
mkdir -pv ~/.vim/templates
ln -svf templates/xetex ~/.vim/templates/xetex
ln -svf templates/python ~/.vim/templates/python
ln -svf templates/html ~/.vim/templates/html
ln -sfv $HOME/devel/dot-files/gvimrc $HOME/.gvimrc
ln -sfv $HOME/devel/dot-files/vimrc $HOME/.vimrc
ln -sfv $HOME/devel/dot-files/xinitrc $HOME/.xinitrc
ln -sfv $HOME/devel/dot-files/bashrc $HOME/.bashrc
ln -sfv $HOME/devel/dot-files/bash_profile $HOME/.bash_profile
ln -sfv $HOME/devel/dot-files/bash_aliases $HOME/.bash_aliases
ln -sfv $HOME/devel/dot-files/gitconfig $HOME/.git_config
ln -sfv $HOME/devel/dot-files/valgrindrc $HOME/.valgrindrc
