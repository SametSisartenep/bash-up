# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
#  local branch
#  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
#    if [[ "$branch" == "HEAD" ]]; then
#      branch='detached*'
#    fi
#    git_branch="($branch)"
#  else
#    git_branch="(-)"
#  fi
#}

#find_git_dirty() {
#  local status=$(git status --porcelain 2> /dev/null)
#  if [[ "$status" != "" ]]; then
#    git_dirty='✗'
#    git_color='196m'
#  else
#    git_dirty='✓'
#    git_color='82m'
#  fi
#}

# PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\e[38;5;160m\]\u\[\e[m\] \[\e[38;5;240m\]に\[\e[m\] \[\e[38;5;166m\]\h\[\e[m\] \[\e[38;5;240m\]で\[\e[m\] \[\e[38;5;226m\]\W\[\e[m\]
\[\e[38;5;43m\]]»\[\e[m\] '
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# user-defined aliases
alias saltar='clear && ll'
alias rmhard='rm -irv'
alias get_window_geometry="xwininfo -id $(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"

# user-defined functions
cd_js () {
  NODE_DEV_DIR="/home/samet/Documentos/Web Development/nodeJS/"
  BUBBLES_DIR="$NODE_DEV_DIR""bubbles/"
  BUBBLES_MODULES_DIR="$NODE_DEV_DIR""bubbles-modules/"
  NAE_DIR="$NODE_DEV_DIR""naturae-animus-engine/"
  BOOKS_DIR="$NODE_DEV_DIR""Books/"
  AR_DRONE_DIR="$NODE_DEV_DIR""drones/ar-drone-2.0-dev/"
  HARDWARE_DIR="$NODE_DEV_DIR""hardware/"

  PUNTA_CANA_DIR="$NODE_DEV_DIR""../punta-cana/excursionesenpuntacana.com/"

  PHANTOM_DEV_DIR="/home/samet/Documentos/Web Development/PhantomJS/"

  case "$1" in
    "-v"|"--version") echo "v1.0.0"
      ;;
    "-n"|"--node") if [ "$2" ]; then
            directory="$NODE_DEV_DIR""$2"
            cd "$directory"
          else
            cd "$NODE_DEV_DIR"
          fi
      ;;
    "-p"|"--phantom") if [ "$2" ]; then
            directory="$PHANTOM_DEV_DIR""$2"
            cd "$directory"
          else
            cd "$PHANTOM_DEV_DIR"
          fi
      ;;
    "-P"|"--project") case "$2" in
          "bb" | "bubbles") cd "$BUBBLES_DIR"
            ;;
          "nae") cd "$NAE_DIR"
            ;;
          "books") cd "$BOOKS_DIR"
            ;;
          "bm"|"bubbles-modules") if [ "$3" ]; then
                  directory="$BUBBLES_MODULES_DIR""$3"
                  cd "$directory"
                else
                  cd "$BUBBLES_MODULES_DIR"
                fi
            ;;
          "d"|"drone")
              cd "$AR_DRONE_DIR"
            ;;
          "hardware"|"hw")
              cd "$HARDWARE_DIR""$3"
            ;;
          "punta-cana")
              cd "$PUNTA_CANA_DIR"
            ;;
          *) echo "Specified project <$2> does not exist."
            ;;
          esac
      ;;
    "-h"|"--help") echo -e "cd_js [option] [argument]\n Options:\n  -v, --version | -n, --node | -p, --phantom | -P, --project | -h, --help"
      ;;
    *) echo "Bye :)"
      ;;
  esac
}

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

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

export NVM_DIR="/home/samet/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/Documentos/node-dev/mongodb/bin:$PATH"

export PATH="/usr/local/go/bin:$PATH"

GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=Solarized

source ~/.bash-git-prompt/gitprompt.sh

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}

# LLVM Path
export PATH="$HOME/Documentos/llvm-dev/llvm/build/Release+Asserts/bin:$PATH"

# Google Depot Tools
export PATH="$HOME/Documentos/v8-engine-dev/depot_tools:$PATH"

# V8 Engine
export PATH="$HOME/Documentos/v8-engine-dev/v8/out/x64.release:$PATH"
