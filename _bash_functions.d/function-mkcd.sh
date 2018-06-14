# shellcheck disable=SC2148

# Function: mkcd()
#
# Description:
#   Create folder and change to it.
#
# Parameters:
#   $1 - folder name to create.
#
# Example:
#   mkcd <foldername>
#
function mkcd() {
	mkdir -p "${*}"
	cd "${*}"
}
