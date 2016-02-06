#!/bin/sh
ln -s ./.inputrc ~/.inputrc
ln -s ./.zshrc ~/.zshrc
ln -s ./.zshenv ~/.zshenv
ln -s ./.vimrc ~/.vimrc
ln -s ./.gvimrc ~/.gvimrc
ln -s ./.vim ~/.vim
ln -s ./.vrapperrc ~/.vrapperrc
ln -s ./.screenrc ~/.screenrc
ln -s ./.ccl-init.lisp ~/.ccl-init.lisp
ln -s ./.gitignore ~/.gitignore
ln -s ./.tmux.conf ~/.tmux.conf
ln -s ./.tmuxinator ~/.tmuxinator
ln -s ./.xvimrc ~/.xvimrc
ln -s ./.vimpressrc ~/.vimpressrc
if [ `uname` = "Darwin" ];then
    ln -s ./.zshrc.mac ~/.zshrc.mac.sh
elif [ `uname` = "Linux" ];then
    ln -s ./.zshrc.linux ~/.zshrc.linux.sh
else
    ln -s ./.zshrc.cygwin ~/.zshrc.cygwin.sh
fi
chmod +x ./githooks/post-commit
cp ./githooks/post-commit .git/hooks/

