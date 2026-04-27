# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

GIT_PS1_SHOWDIRTYSTATE=auto
GIT_PS1_SHOWSTASHSTATE=auto
GIT_PS1_SHOWUNTRACKEDFILES=auto
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_COMPRESSSPARSESTATE=auto
GIT_PS1_SHOWCONFLICTSTATE=auto
GIT_PS1_DESCRIBE_STYLE='branch'

if [ "$color_prompt" = yes ]; then
    PS1='$(date +%H:%M) ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1) \$ '
else
    PS1='$(date +%H:%M) ${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1) \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# My stuff
################################################################################

# PATH

PATH=$PATH:/opt/zig
PATH=$PATH:/opt/android-studio/bin

# Editors

export SUDO_EDITOR='nvim'
export VISUAL='nvim'
export EDITOR='nvim'

# Aliases
alias g='git'
alias v='nvim'

# Dotfiles git repo

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles-vim='GIT_DIR="$HOME/.dotfiles/" GIT_WORK_TREE="$HOME" nvim -S "$HOME/.config/nvim/session/dotfiles.vim"'
alias df=dotfiles
alias dfv=dotfiles-vim

# yt-dlp

# Getting music off of YouTube
ytmp3() { yt-dlp -x --audio-format "mp3" -P ~/Music "$@"; }

# Options for downloading live streams
ytstream() {
	yt-dlp --live-from-start --wait-for-video 1 -P "$HOME/Downloads/yt-dlp/Livestream Archives" "$@"
	notify-send "YouTube stream over" "Download complete"
}
# 480p at ~30fps is a good balance between quality and size
ytstreamoptimal() { ytstream -S "res:480,fps:30" "$@"; }
ytstreambest() { ytstream "$@"; }
ytstreamchat() { ytstream --skip-download --write-subs --sub-langs "en.*,ja,live_chat" "$@"; }
ytautosubs() { yt-dlp --skip-download --write-auto-subs "$@"; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS="
  --walker-skip cache,caches,.cargo
  --walker-skip .mozilla,.thunderbird
  --walker-skip .git,node_modules,target,__pycache__,.venv
  "

export FZF_ALT_C_OPTS="
  --preview 'ls -A {}'
  "

export FZF_CTRL_T_OPTS="
  --preview 'cat {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  "

# pyenv
################################################################################

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

PATH=$PATH:~/.pyenv/bin
. "$HOME/.cargo/env"

# Deno
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.deno/env"
source $HOME/.local/share/bash-completion/completions/deno.bash

################################################################################

# Completions
for f in ~/.bash_completion/*; do source "$f"; done
