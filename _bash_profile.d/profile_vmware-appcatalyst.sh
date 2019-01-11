# shellcheck disable=SC2148

# Start VMware AppCatalyst daemon if properly installed

# If VMware AppCatalyst is properly installed, fork start its daemon...
if command -v appcatalyst-daemon > /dev/null; then
	bash_fork "appcatalyst-daemon"
fi
