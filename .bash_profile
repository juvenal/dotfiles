#
# .bash_profile
#

# Get the aliases and functions
if [[ -f ~/.bashrc ]]; then
	source ~/.bashrc
fi

# Screen definition for X11 Server
export DISPLAY=localhost:0.0

# Define the 3DLight root path
export DELIGHT=/Applications/3Delight
# Include 3DLight configuration
source ~/.3dlight_bash

# Define Pixie root path
export PIXIEHOME=/usr/local/Pixie
# Include Pixie configuration
source ~/.pixie_bash

# Define Aqsis root path
export AQSISHOME=/Applications/Aqsis.app
# Include Aqsis configuration
source ~/.aqsis_bash

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

# User specific environment and startup programs
export PATH=${HOME}/.local/bin:${HOME}/.bin:/usr/share/cake/cake/scripts:${HOME}/.gem/ruby/2.0.0/bin:${PATH}

# RVM install as a function to the active shell
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
