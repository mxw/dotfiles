#
# ~/.profile: Executed by the command interpreter for login shells.  This file
# is not read by bash(1) if ~/.bash_profile or ~/.bash_login exists.
#

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return


#-----------------------------------------
# Basic settings.
#-----------------------------------------

# Set the default umask in case it isn't set elsewhere.
umask 022

# Use vim.
export VISUAL="vim"
export EDITOR="vim"


#-----------------------------------------
# Shell and OS types.
#-----------------------------------------

if [ -n "$BASH_VERSION" ]; then
  PROFILE_SHELL=bash
elif [ -n "$ZSH_VERSION" ]; then
  PROFILE_SHELL=zsh
fi

OSNAME=${OSTYPE//[0-9.]/}

if [ "$OS_NAME" == 'darwin' ] && command -v brew >/dev/null 2>&1; then
  LOCAL_DIR=$(brew --prefix)
else
  LOCAL_DIR='/usr/local'
fi


#-----------------------------------------
# Early sourcing.
#-----------------------------------------

# Early local profile.
if [ -f "$HOME/.profile.before" ]; then
  . "$HOME/.profile.before"
fi

# Source a shell-specific early config.
if [ -f "$HOME/.${PROFILE_SHELL}rc.before" ]; then
  . "$HOME/.${PROFILE_SHELL}rc.before"
fi


#-----------------------------------------
# Path and prompt.
#-----------------------------------------

# Update PATH.
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
if [ "$OS_NAME" == 'darwin' ] && [ -d "/Library/TeX/texbin" ]; then
  PATH="/Library/TeX/texbin:$PATH"
fi
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

COLOR_PROMPT=1

# Make sure PROMPT_COMMAND has no trailing ';'.
if [ ! -z "$PROMPT_COMMAND" ]; then
  trailing_space="${PROMPT_COMMAND##*[![:space:]]}"

  PROMPT_COMMAND="${PROMPT_COMMAND%$trailing_space}"
  if [ "${PROMPT_COMMAND: -1}" == ';' ]; then
    PROMPT_COMMAND="${PROMPT_COMMAND#;}"
  fi

  unset trailing_space
fi


#-----------------------------------------
# Sourcing.
#-----------------------------------------

# Shell-specific configs.
if [ -f "$HOME/.${PROFILE_SHELL}rc" ]; then
  . "$HOME/.${PROFILE_SHELL}rc"
fi

# Everything else.
for file in $(ls "$HOME/.profile.d/"); do
  . "$HOME/.profile.d/$file"
done

# Source our SCM prompt scripts.
if [ -f "$HOME/.gitprompt" ]; then
  . "$HOME/.gitprompt"
fi
if [ -f "$HOME/.hgrc.d/hgprompt" ]; then
  . "$HOME/.hgrc.d/hgprompt"
fi
