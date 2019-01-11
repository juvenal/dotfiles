# shellcheck disable=SC2148

# Set some required global path constants for VAGRANT
if command -v vagrant > /dev/null; then
    export VAGRANT_HOME="${HOME}/virtualMachines/Vagrant/Config"
    export VAGRANT_DOTFILE_PATH="${HOME}/virtualMachines/Vagrant/Running"
fi
