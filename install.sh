#!/bin/sh
p=`pwd -P`
ln -s $p/.inputrc ~/.inputrc
ln -s $p/.zshrc ~/.zshrc
ln -s $p/.zshenv ~/.zshenv
ln -s $p/.vimrc ~/.vimrc
ln -s $p/.gvimrc ~/.gvimrc
ln -s $p/.vim ~/.vim
ln -s $p/.vrapperrc ~/.vrapperrc
ln -s $p/.screenrc ~/.screenrc
ln -s $p/.ccl-init.lisp ~/.ccl-init.lisp
ln -s $p/.gitignore ~/.gitignore
ln -s $p/.tmux.conf ~/.tmux.conf
ln -s $p/.tmuxinator ~/.tmuxinator
ln -s $p/.xvimrc ~/.xvimrc
ln -s $p/.vimpressrc ~/.vimpressrc
if [ `uname` = "Darwin" ];then
    ln -s $p/.zshrc.mac ~/.zshrc.mac.sh
elif [ `uname` = "Linux" ];then
    ln -s $p/.zshrc.linux ~/.zshrc.linux.sh
else
    ln -s $p/.zshrc.cygwin ~/.zshrc.cygwin.sh
fi
chmod +x ./githooks/post-commit
cp ./githooks/post-commit .git/hooks/

