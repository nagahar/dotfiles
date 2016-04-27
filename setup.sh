#!/bin/sh
echo "start setup dot files"

chmod +x setup_hooks.sh
./setup_hooks.sh

p=`pwd -P`
echo "######start setup $HOME######"
ln -s $p/dotgitignore ~/.gitignore_global
ln -s $p/dotgitconfig ~/.gitconfig
ln -s $p/.jshintrc ~/.jshintrc
ln -s $p/.inputrc ~/.inputrc
ln -s $p/.tmux.conf ~/.tmux.conf
ln -s $p/.tmuxinator ~/.tmuxinator
ln -s $p/.ccl-init.lisp ~/.ccl-init.lisp
echo "######start setup zsh######"
ln -s $p/.zshrc ~/.zshrc
ln -s $p/.zshenv ~/.zshenv
if [ `uname` = "Darwin" ];then
    ln -s $p/.zshrc.mac.sh ~/.zshrc.mac.sh
elif [ `uname` = "Linux" ];then
    ln -s $p/.zshrc.linux.sh ~/.zshrc.linux.sh
else
    ln -s $p/.zshrc.cygwin.sh ~/.zshrc.cygwin.sh
fi
echo "######finished setup zsh######"
echo "######finished setup $HOME######"

echo "######start setup vim######"
if [ -d $HOME/.vim ]; then
    echo "already exists! $HOME/.vim"
    exit;
fi
ln -s $p/.vimrc ~/.vimrc
ln -s $p/.gvimrc ~/.gvimrc
ln -s $p/.vim ~/.vim
git clone git://github.com/Shougo/neobundle.vim ./.vim/bundle/neobundle.vim
vi -u $p/.vimrc +NeoBundleInstall +q
echo "######finished setup vim plugins######"

echo "######finished setup dot files######"
