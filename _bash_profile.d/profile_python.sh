# shellcheck disable=SC2148

# Python virtual environments and settings configuration

# Python pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# If Python virtual environments were installed
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    # Activate Python virtualenv commands
    source /usr/local/bin/virtualenvwrapper.sh

    # Python virtualenvwapper settings
    export WORKON_HOME="${HOME}/.python_virtual_envs"
    [[ -d "${WORKON_HOME}" ]] \
        && chmod 0755 "${WORKON_HOME}" \
        || mkdir -p -m 0755 "${WORKON_HOME}"

    # Python pip should only run if there is a virtualenv currently activated
    export PIP_REQUIRE_VIRTUALENV=true

    # cache python pip-installed packages to avoid re-downloading
    export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"
    [[ -d "${PIP_DOWNLOAD_CACHE}" ]] \
        && chmod 0755 "${PIP_DOWNLOAD_CACHE}" \
        || mkdir -p -m 0755 "${PIP_DOWNLOAD_CACHE}"
else
    echo "Python virtualenv isn't installed!"
    echo ""
    echo "To install it, make sure you are using Homebrew python, then install virtualenv"
    echo "with the following command:"
    echo "  $ PIP_REQUIRE_VIRTUALENV=false pip install virtualenvwrapper"
    echo ""
    echo "Then, you'll need to reload this config script with:"
    echo "  $ source ~/.bash_profile.d/profile_python.sh"
    echo ""
fi
