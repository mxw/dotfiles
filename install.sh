#!/bin/bash
#
# Mostly copied from:
#   https://github.com/zenazn/dotfiles/blob/master/install.sh

ROOT=$(cd "$(dirname "$0")" && pwd)

function green { printf "\033[32m$1\033[0m\n"; }
function yellow { printf "\033[33m$1\033[0m\n"; }
function red { printf "\033[31m$1\033[0m\n"; }

# Install a file or directory to a given path by symlinking it, printing nice
# things along the way.
function install {
  local from="$1" to="$2" from_="$ROOT/$1" to_="$HOME/$2"

  if [ ! -e "$from_" ]; then
    red "ERROR: $from doesn't exist! This is an error in $0."
    return 1
  fi

  if [ ! -e "$to_" ]; then
    yellow "Linking ~/$to => $from"

    if [ -d "$from_" ]; then
      ln -s "$from_/" "$to_"
    else
      ln -s "$from_" "$to_"
    fi
  else
    local link
    link=$(readlink "$to_")
    if [ "$?" == 0 -a \( "$link" == "$from_" -o "$link" == "$from_/" \) ]; then
      green "~/$to already links to $from!"
    else
      red "Error linking ~/$to to $from: $to already exists!"
      if ask "Link anyway?"; then
        rm -f "$to_"
        install "$from" "$to"
      fi
    fi
  fi
}

function install_dot {
  install "$1" ".$1"
}

function ask {
  local question="$1" default_y="$2" yn
  if [ -z "$default_y" ]; then
    read -p "$question (y/N)? "
  else
    read -p "$question (Y/n)? "
  fi
  yn=$(echo "$REPLY" | tr "A-Z" "a-z")
  if [ -z "$default_y" ]; then
    test "$yn" == 'y' -o "$yn" == 'yes'
  else
    test "$yn" == 'n' -o "$yn" == 'no'
  fi
}

# Run the given command under a me-only umask.  Useful for atomically creating
# sensitive files and directories.
function umask_mine {
  local old_umask=$(umask) ret
  umask 0077
  "$@"
  ret="$?"
  umask "$old_umask"
  return "$ret"
}

function is_mac { test "$(uname -s)" == "Darwin"; }
function is_linux { test "$(uname -s)" == "Linux"; }

# Try to detect if we're on a server or a personal computer.
function is_server {
  is_mac && return 1
  if is_linux; then
    dpkg -l ubuntu-desktop &>/dev/null && return 1
    [[ "$(uname -r)" == *server* ]] && return 0
    [[ "$(uname -r)" == *linode* ]] && return 0
  fi

  red "Couldn't tell if this was a server or desktop, just guessing!"
  return 0
}

# Initialize dotfiles submodules.
if ! git config --get-regexp submodule* > /dev/null; then
  if ask "Initialize submodules?"; then
    git submodule init
    git submodule update
  fi
fi

# Vroom vroom!
install_dot "dircolors"
install_dot "emacs"
install_dot "gitconfig"
install_dot "gitignore"
install_dot "gitprompt"
install_dot "hgrc"
install_dot "inputrc"
install_dot "screenrc"
install_dot "vim"
install_dot "vimrc"
is_mac && install_dot "slate.js"

mkdir -p "$HOME/.profile.d"
install_dot "profile"
install_dot "profile.d/10-completion"
install_dot "profile.d/20-color"
install_dot "profile.d/30-aliases"
install_dot "bashrc"

mkdir -p "$HOME/.hgrc.d"
install_dot "hgrc.d/git-style.hg"

# The SSH folder most likely already exists, and in any event we don't want to
# manage it ourselves.  If we are creating it for the first time, however, we
# should lock down the permissions.
if [ ! -e "$HOME/.ssh" ]; then
  umask_mine mkdir "$HOME/.ssh"
fi

install_dot "ssh/rc"
if is_server; then
  install_dot "ssh/environment"
else
  install_dot "ssh/config"
fi
