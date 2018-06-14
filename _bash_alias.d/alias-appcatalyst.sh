#
# shellcheck disable=SC2148
#

# Utilities for VMware AppCatalyst daemon if installed
if [[ -n "$(command -v appcatalyst-daemon)" ]]; then
	alias catalyst_vmnet='sudo /opt/vmware/appcatalyst/libexec/services/services.sh'
	alias catalyst_start='bash_fork appcatalyst-daemon'
	alias catalyst_stop='gkill -TERM -F ${HOME}/.local/var/run/appcatalyst-daemon.pid'
fi
