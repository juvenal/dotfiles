# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ -z ${PS1} ]] && return

# Check to see if we are running inside a tmux session
[[ -n ${TMUX} ]] && echo "Running in a tmux session."

# Set to yes for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=no

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && \
	eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "${TERM}" in
    rxvt*|xterm-*color|screen-*color)
		color_prompt=yes
		;;
	*)
		color_prompt=no
		;;
esac

if [[ "${force_color_prompt}" == "yes" ]]; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
    else
		color_prompt=no
    fi
	# Clear unused variables
	unset force_color_prompt
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f ~/.bash_alias ]]; then
    source ~/.bash_alias
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bashrc and/or /etc/profile
# Load personal completions if defined
if [[ -f ~/.bash_completion ]]; then
    source ~/.bash_completion
# Otherwise, load defaults
elif [[ -f /etc/bash_completion ]]; then
	source /etc/bash_completion
fi

# Finally, set the tweaked, custom prompt.
if [[ -f ~/.bash_prompt ]]; then
	source ~/.bash_prompt
else
	export PS1='[\u@\h \W]$ '
fi

export PATH="${PATH}:${HOME}/.rvm/bin" # Add RVM to PATH for scripting
