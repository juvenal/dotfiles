# brew-setup_profile.sh
#
# shellcheck disable=SC2148

# Check if the path was already adjusted. If it wasn't, adjust it, otherwise let
# it alone.
if [[ -d "/usr/local/sbin" ]]; then
	if grep -qv ":/usr/local/sbin:" <<< "${PATH}"; then
		PATH=${PATH//:\/usr\/sbin:/:\/usr\/local\/sbin:\/usr\/sbin:}
	fi
fi
# Set an access token to increase bandwidth for homebrew github queries.
export HOMEBREW_GITHUB_API_TOKEN=
