# shellcheck disable=SC2148

# RVM install as a function to the active shell
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && \
	source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Set user PATH.
export PATH="${HOME}/.rvm/bin:${PATH}" # Add RVM to PATH for scripting
