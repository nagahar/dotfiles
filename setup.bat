echo "######start setup %HOMEPATH%######"
mklink "c:%HOMEPATH%\.inputrc" "%~dp0\.inputrc"
mklink "c:%HOMEPATH%\.jshintrc" "%~dp0\.jshintrc"
echo "######start setup zsh######"
mklink "c:%HOMEPATH%\.zshrc" "%~dp0\.zshrc"
mklink "c:%HOMEPATH%\.zshenv" "%~dp0\.zshenv"
mklink "c:%HOMEPATH%\.zshrc.cygwin" "%~dp0\.zshrc.cygwin.sh"
echo "######finished setup zsh######"
echo "######finished setup %HOMEPATH%######"

echo "######start setup tex######"
mklink /D "c:\w32tex\share\texmf-local" "%~dp0\texmf-local"
echo "######finished setup tex######"

echo "######start setup vim######"
mklink "c:%HOMEPATH%\_vimrc" "%~dp0\.vimrc"
mklink "c:%HOMEPATH%\_gvimrc" "%~dp0\.gvimrc"
mklink /D "c:%HOMEPATH%\vimfiles" "%~dp0\.vim"
git clone git://github.com/Shougo/neobundle.vim %~dp0/.vim/bundle/neobundle.vim
vi +NeoBundleInstall +q
echo "######finished setup vim plugins######"
echo "######start setup vim utils######"
mklink "c:%HOMEPATH%\_vrapperrc" "%~dp0\.vrapperrc"
mklink "c:%HOMEPATH%\_viemurc" "%~dp0\_viemurc"
mklink "c:%HOMEPATH%\.ideavimrc" "%~dp0\.xvimrc"
mklink "c:%HOMEPATH%\.vsvimrc" "%~dp0\.xvimrc"
echo "######finished setup vim utils######"
pause
