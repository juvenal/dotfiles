# shellcheck disable=SC2148,SC1090

# Travis Lint gem config

# Required by travis gem
if [[ -f "${HOME}/.travis/travis.sh" ]]; then
	source "${HOME}"/.travis/travis.sh
fi
