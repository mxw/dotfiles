#
# ~/.bashrc: Bash-specific shell configuration only.
#
# Much of this is adapted from the default Ubuntu ~/.bashrc.
#

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files; see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#-----------------------------------------
# History.
#-----------------------------------------

# Append to the history file rather than overwriting.
shopt -s histappend

# Ignore duplicate lines and lines starting with whitespace.
HISTCONTROL=ignoredups:ignorespace

# Set limits.
HISTSIZE=1000
HISTFILESIZE=2000

# Save history at end-of-command rather than end-of-session.  This is necessary
# for history-saving in screen.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"


#-----------------------------------------
# Prompt.
#-----------------------------------------

PS1='\[\e[32m\]\u@\h\[\e[00m\]:\[\e[35;1m\]\w\[\e[00m\]\$ '
PROMPT_COMMAND="${PROMPT_COMMAND}; printf '\n'"

# Identify our chroot if we have one.
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
  PS1="${debian_chroot:+($debian_chroot)}$PS1"
fi

TITLE='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]'

# If this is an xterm, set the title to '(chroot)user@host: dir'.
case "$TERM" in
  xterm*|rxvt*) PS1="$TITLE$PS1" ;;
esac

BASE_PS1="$PS1"
