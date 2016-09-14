#!/bin/sh
ln -s ~/Dropbox/Documents/env/.inputrc ~/.inputrc
ln -s ~/Dropbox/Documents/env/.zshrc ~/.zshrc
ln -s ~/Dropbox/Documents/env/.zshenv ~/.zshenv
ln -s ~/Dropbox/Documents/env/.zshrc.linux ~/.zshrc.linux.sh
ln -s ~/Dropbox/Documents/env/.vimrc ~/.vimrc
ln -s ~/Dropbox/Documents/env/.gvimrc ~/.gvimrc
ln -s ~/Dropbox/Documents/env/.vim ~/.vim
ln -s ~/Dropbox/Documents/env/.vrapperrc ~/.vrapperrc
ln -s ~/Dropbox/Documents/env/.screenrc ~/.screenrc
ln -s ~/Dropbox/Documents/env/.ccl-init.lisp ~/.ccl-init.lisp
if [ `uname` = "Darwin" ];then
	ln -s ~/Dropbox/Documents/env/texmf-local /opt/local/share/texmf-local/texmf-local
fi

