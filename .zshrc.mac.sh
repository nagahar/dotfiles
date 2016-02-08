MYPATH=$HOME/Documents/Projects/sandbox
export PATH=$MYPATH/scripts:$PATH:/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin
export CLASSPATH=$CLASSPATH:.:$HOME/src/jar
# add@2015-03-29
#export DYLD_LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
#export DYLD_FALLBACK_LIBRARY_PATH

# Add if-branch change@2014-01-18
JAVA_HOME=`/usr/libexec/java_home -v 1.8` 2> /dev/null;
if [ $? -eq 0 ]; then
    export JAVA_HOME
else
    JAVA_HOME=""
fi

# rbenv
#if which rbenv > /dev/null; then
#    eval "$(rbenv init -)"
#fi

#MACVIM=/usr/local/Cellar/macvim-kaoriya/Head/MacVim.app
MACVIM=/Applications/MacVim.app
export VIMRUNTIME=$MACVIM/Contents/Resources/vim/runtime
export EDITOR=$MACVIM/Contents/MacOS/Vim
#export EDITOR=/usr/bin/vim
alias vi="$MACVIM/Contents/MacOS/Vim $@"
alias gvim="open -n -a $MACVIM/Contents/MacOS/MacVim"
alias cemacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias git="/usr/local/bin/git"
# change@2015-02-01
alias ccl="/usr/local/bin/ccl64"
alias cc="/usr/bin/cc -Wall -W -Wformat=2 -Wcast-qual -Wcast-align -Wconversion -Wfloat-equal -Wpointer-arith $@"

[[ -s $(brew --prefix)/etc/autojump.sh ]] && . $(brew --prefix)/etc/autojump.sh

# add@2015-01-10
#if [ -f $HOME/src/google-cloud-sdk/path.zsh.inc ]; then
#    # The next line updates PATH for the Google Cloud SDK.
#    source "$HOME/src/google-cloud-sdk/path.zsh.inc"
#
#    # The next line enables bash completion for gcloud.
#    source "$HOME/src/google-cloud-sdk/completion.zsh.inc"
#fi

# iTerm2の場合だけ実行する
#if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
#    # tmuxがある場合
#    if which tmux > /dev/null; then
#        # tmux(mux dev)自動起動 add@2014-12-27
#        if [ -z "$PS1" ]; then return ; fi
#
#        if [ -z $TMUX ] ; then
#            if [ -z `tmux ls` ] ; then
#                #mux dev
#            else
#                tmux attach
#            fi
#        fi
#
#        # tmux copy & paste add@2014-12-27
#        if [ -n "$TMUX" ]; then
#          alias pbcopy="reattach-to-user-namespace pbcopy"
#        fi
#    fi
#fi

