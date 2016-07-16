#!/bin/bash
# .bash_profile
#
# Interactive settings go here
#

# Set basic variables, get aliases and functions
if [[ -f ~/.bashrc ]]; then
	source ~/.bashrc
fi

# Screen definition for X11 Server
export DISPLAY=:0

# Python wirtualenv disable prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# Python virtualenvwapper settings
export WORKON_HOME=${HOME}/.python_virtual_envs
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

# Python pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# cache python pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=${HOME}/.pip/cache

# Load specific interactive configuration scripts for 3rd party programs
if [[ -d ~/.bash_profile.d ]]; then
	for profile in ~/.bash_profile.d/*_profile.sh; do
		source "${profile}"
	done
fi

# NVM (Node.js Version Manager) Setup
export NVM_DIR="${HOME}/.nvm"
[[ -s "${NVM_DIR}/nvm.sh" ]] && \
	source "${NVM_DIR}/nvm.sh" # This loads nvm

# GVM {Go Version Manager} Setup
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && \
	source "${HOME}/.gvm/scripts/gvm"

# RVM install as a function to the active shell
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
