# ~/.bashrc: Executed by bash(1) for non-login shells.
#
# Ripped from the Ubuntu default .bashrc.

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Get the base name of our operating system.
OS=${OSTYPE//[0-9.]/}

# Ignore duplicate lines and lines starting with whitespace in history.
HISTCONTROL=ignoredups:ignorespace

# Set limits on history.
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file rather than overwriting.
shopt -s histappend

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below).
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color).
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt.
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429).
    # (Lack of such support is extremely rare, and such a case would tend to
    # support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir.
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# Enable color support of ls and grep.
if [ -x /usr/bin/dircolors -o -x /usr/local/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  # Always use a colorized GNU ls.
  if [ "$OS" = 'darwin' -a -x /usr/local/bin/gls ]; then
    alias ls='gls --color=auto'
  else
    alias ls='ls --color=auto'
  fi

  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Source additional aliases.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Ignore specific filetypes in autocomplete.
export FIGNORE=.o:$FIGNORE

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
  if [ -n $(command -v brew) -a -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# Use vim.
export VISUAL=vim
export EDITOR=vim
