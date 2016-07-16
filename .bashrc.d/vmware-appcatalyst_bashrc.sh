#!/bin/bash
#
# Start VMware AppCatalyst daemon if properly installed
#

# If VMware AppCatalyst is properly installed, fork start its daemon...
if [[ -n "$(which appcatalyst-daemon)" ]]; then
	bash_fork "appcatalyst-daemon"
fi
