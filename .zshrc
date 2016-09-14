# users generic .zshrc file for zsh(1)

## Default shell configuration
#
# set prompt
#
autoload colors
colors

source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

case ${UID} in
0)
precmd () {
  PROMPT="%B%{${fg[red]}%}%m:%1/ %n$(__git_ps1)
#%{${reset_color}%}%b "
}
  RPROMPT="[%~]"
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
precmd () {
  PROMPT="%{${fg[green]}%}%m:%1/ %n$(__git_ps1)
%%%{${reset_color}%} "
}
  RPROMPT="[%~]"
  PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[green]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# remove duplicated in directory stack
setopt pushd_ignore_dups

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# complete from '=' ( --prefix=/usr)
#
setopt magic_equal_subst

# print Japanese character in complete list
#
setopt print_eight_bit

# ignore case in completion
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# use colored completion in kill
#
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# set default permission
umask 022

# off beep
#
setopt no_beep

# off beep in completion
#
setopt nolistbeep

# comment out after '#'
#
setopt interactive_comments

# sort numeric
#
setopt numeric_glob_sort

# restrict redirect of zsh
#
setopt no_multios

# print character which doesn't have <CR>
unsetopt promptcr

# don't logg off by using ctrl-d
#setopt ignore_eof

# don't kill background job when you log off
#
#setopt no_hup

# don't confirm background job when you log off
#
#setopt no_checkjobs

# notify when the job is finished
#
setopt notify

# confirm before executing rm *
#
setopt rm_star_wait

# don't confirm before executing rm *
#
#setopt rm_star_silent

# don't overwrite in redirect
#
#setopt no_clobber

# overwrite in redirect
#
unsetopt no_clobber

# convert symblic link to real file
#
#setopt chase_links

# print return cod when it is other than 0
#
#setopt print_exit_value

# set one line editing mode, not multiline editing
#
#setopt single_line_zle

# remove '/' from WORDCHARS
#
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# execute 'ls' after 'cd'
#
#function chpwd() { ls }

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# undo
#
bindkey "^z" undo

# set incremental search
#
bindkey "^r" history-incremental-search-backward
bindkey "^s" history-incremental-search-forward

# remove previous character from cursor
#
bindkey '^u' backward-kill-line

# remove previouse word from cursor
#
#bindkey "^h" backward-kill-word
#

# print buffer stack by '^q'
#
setopt noflowcontrol
bindkey '^q' push-line-or-edit

## move to beggining of the line
##
#bindkey "^a" vi-beginning-of-line
#
## move to end of the line
##
#bindkey "^e" vi-end-of-line
#
## move to backward char
##
#bindkey "^h" vi-backward-char
#
## move to forward char
##
#bindkey "^l" vi-forward-char
#
## delete the char under the cursor
##
#bindkey "^d" vi-delete-char


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups  # remove duplicate command
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
setopt append_history        # add history to .zsh_history
setopt inc_append_history    # add history incrementally
setopt hist_no_store         # don't add 'history' command
setopt hist_reduce_blanks    # remove blanks
#setopt hist_ignore_space    # ignore blank-initiated command

# print all history
#
function history-all { history -E 1 }

## Completion configuration
#
autoload -U compinit
compinit -u

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
# deleta@2014-12-29
#alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -laF"
alias du="du -h"
alias df="df -h"
alias h="history -E -32"
alias su="su -l"
#alias cd="pushd"
#alias bd="popd"
alias cx="chmod +x"

## terminal configuration
#
#unset LSCOLORS
#case "${TERM}" in
#xterm)
#  export TERM=xterm-color
#  ;;
#kterm)
#  export TERM=kterm-color
#  # set BackSpace control character
#  stty erase
#  ;;
#cons25)
#  unset LANG
#  export LSCOLORS=ExFxCxdxBxegedabagacad
#  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#  zstyle ':completion:*' list-colors \
#   'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
#    ;;
#esac
#
export LSCOLORS=GxFxCxdxBxegedabagacad
export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors \
   'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  #export LSCOLORS=exfxcxdxbxegedabagacad
  #export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  #zstyle ':completion:*' list-colors \
  #  'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  export LSCOLORS=gxfxcxdxbxegedabagacad
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

# delete@2014-12-27
# set screen
#
# screen session dir
#if [ `uname` = "Darwin" ];then
#export SCREENDIR=/Users/nagahara/.screen
#elif [ `uname` = "Linux" ];then
#export SCREENDIR=/home/nagahara/.screen
#else
#export SCREENDIR=/cygdrive/c/Users/nagahara/.screen
#fi
## display command on status line on screen
#if [ "$TERM" = "screen" ]; then
#  precmd () { echo -n "\ek$(basename $(pwd))\e\\" }
#  preexec() {
#    # see [zsh-workers:13180]
#    # http://www.zsh.org/mla/workers/2000/msg03993.html
#    emulate -L zsh
#    local -a cmd; cmd=(${(z)2})
#    case $cmd[1] in
#      fg)
#      if (( $#cmd == 1 )); then
#        cmd=(builtin jobs -l %+)
#      else
#        cmd=(builtin jobs -l $cmd[2])
#      fi
#      ;;
#      %*)
#      cmd=(builtin jobs -l $cmd[1])
#      ;;
#      cd)
#      if (( $#cmd == 2)); then
#        cmd[1]=$cmd[2]
#      fi
#      ;&
#      *)
#      echo -n "\ek$cmd[1]:t\e\\"
#      return
#      ;;
#    esac
#
#    local -A jt; jt=(${(kv)jobtexts})
#
#    $cmd >>(read num rest
#    cmd=(${(z)${(e):-\$jt$num}})
#    echo -n "\ek$cmd[1]:t\e\\") 2>/dev/null
#  }
#fi
## boot screen
#[ ${STY} ] || screen -rx || screen -D -RR
##if [ $SHLVL = 1 ];then
##  screen -xR
##fi

## load os .zshrc configuration file
#
if [ `uname` = "Darwin" ];then
  [ -f ~/.zshrc.mac.sh ] && source ~/.zshrc.mac.sh
elif [ `uname` = "Linux" ];then
  [ -f ~/.zshrc.linux.sh ] && source ~/.zshrc.linux.sh
else
  [ -f ~/.zshrc.cygwin.sh ] && source ~/.zshrc.cygwin.sh
fi

