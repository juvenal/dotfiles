#! /bin/bash
#
# Set some required global path constants for VAGRANT
#

export VAGRANT_HOME="${HOME}/Documents/.Virtual_Machines/Vagrant/Config"
export VAGRANT_DOTFILE_PATH="${HOME}/Documents/.Virtual_Machines/Vagrant/Running"

# If VMware AppCatalyst is properly installed, fork start its daemon...
if [[ -n "$(which appcatalyst-daemon)" ]]; then
	bash_fork "appcatalyst-daemon"
fi
