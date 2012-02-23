#! /bin/sh
mkdir -pv ~/.vim/templates
mkdir -pv ~/.vim/snippets
ln -svf templates/xetex ~/.vim/templates/xetex
ln -svf templates/python ~/.vim/templates/python
ln -svf templates/html ~/.vim/templates/html
ln -svf $HOME/devel/dot-files/snippets/c-my.snippets ~/.vim/snippets/c-my.snippets
ln -svf $HOME/devel/dot-files/snippets/tex-my.snippets ~/.vim/snippets/tex-my.snippets
ln -svf $HOME/devel/dot-files/snippets/javascript-my.snippets ~/.vim/snippets/javascript-my.snippets
ln -svf $HOME/devel/dot-files/snippets/scheme-my.snippets ~/.vim/snippets/scheme-my.snippets
ln -svf $HOME/devel/dot-files/snippets/html-my.snippets ~/.vim/snippets/html-my.snippets
ln -sfv $HOME/devel/dot-files/gvimrc $HOME/.gvimrc
ln -sfv $HOME/devel/dot-files/vimrc $HOME/.vimrc
ln -sfv $HOME/devel/dot-files/xinitrc $HOME/.xinitrc
ln -sfv $HOME/devel/dot-files/bashrc $HOME/.bashrc
ln -sfv $HOME/devel/dot-files/bash_profile $HOME/.bash_profile
ln -sfv $HOME/devel/dot-files/bash_aliases $HOME/.bash_aliases
ln -sfv $HOME/devel/dot-files/gitconfig $HOME/.git_config
ln -sfv $HOME/devel/dot-files/valgrindrc $HOME/.valgrindrc
