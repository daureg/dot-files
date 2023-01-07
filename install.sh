#! /bin/sh
mkdir -pv ~/.vim/templates
mkdir -pv ~/.vim/snippets
mkdir -pv ~/.vim/ftplugin
HERE=$(pwd)
ln -svf $HERE/templates/xetex ~/.vim/templates/xetex
ln -svf $HERE/templates/python ~/.vim/templates/python
ln -svf $HERE/templates/html ~/.vim/templates/html
ln -svf $HERE/templates/git_commit_template ~/.config/git_commit_template
ln -svf $HERE/snippets/c-my.snippets ~/.vim/snippets/c-my.snippets
ln -svf $HERE/snippets/tex-my.snippets ~/.vim/snippets/tex-my.snippets
ln -svf $HERE/snippets/javascript-my.snippets ~/.vim/snippets/javascript-my.snippets
ln -svf $HERE/snippets/scheme-my.snippets ~/.vim/snippets/scheme-my.snippets
ln -svf $HERE/snippets/html-my.snippets ~/.vim/snippets/html-my.snippets
ln -svf $HERE/python.vim ~/.vim/ftplugin/python.vim
ln -sfv $HERE/gvimrc $HOME/.gvimrc
ln -sfv $HERE/vimrc $HOME/.vimrc
ln -sfv $HERE/nvimrc $HOME/.nvimrc
ln -sfv $HERE/xinitrc $HOME/.xinitrc
ln -sfv $HERE/xserverrc $HOME/.xserverrc
ln -sfv $HERE/bashrc $HOME/.bashrc
ln -sfv $HERE/bash_profile $HOME/.bash_profile
ln -sfv $HERE/bash_aliases $HOME/.bash_aliases
ln -sfv $HERE/gitconfig $HOME/.gitconfig
ln -sfv $HERE/valgrindrc $HOME/.valgrindrc
ln -sfv $HERE/astylerc $HOME/.astylerc
ln -sfv $HERE/pylintrc $HOME/.pylintrc
ln -sfv $HERE/tmux.conf $HOME/.tmux.conf
ln -sfv $HERE/sshconfig $HOME/.ssh/config
ln -sfv $HERE/latexmkrc $HOME/.latexmkrc
ln -sfv $HERE/config.fish $HOME/.config/fish/config.fish
