# shellcheck disable=SC2148

# Start VMware AppCatalyst daemon if properly installed

# If VMware AppCatalyst is properly installed, fork start its daemon...
if [[ -n "$(command -v appcatalyst-daemon)" ]]; then
	bash_fork "appcatalyst-daemon"
fi
