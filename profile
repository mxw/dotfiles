# ~/.profile: Executed by the command interpreter for login shells.  This file
# is not read by bash(1) if ~/.bash_profile or ~/.bash_login exists.
#
# Ripped from the Ubuntu default .profile.

# The default umask is set elsewhere in both Ubuntu and MacOSX.
# umask 022

# Include .bashrc if it exists and we're running bash.
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
	  . "$HOME/.bashrc"
  fi
fi

# Set PATH so it includes our local bin if it exists.
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:/usr/local/bin:$PATH"
fi
