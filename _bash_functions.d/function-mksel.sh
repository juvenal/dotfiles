# shellcheck disable=SC2148

# Funtion: mksel()
#
# Description:
#   Move selection to a (new) folder.
#
# Parameters:
#   $1 - Pathname of new directory/folder to create.
#   $2 - In fact, remaining parameters are filenames to move into $1.
#
# Example:
#   mksel <enclosed_folder> <file> [...]
#
function mksel() {
	dest="${1}"
	if [[ ! -d "${dest}" ]]; then
		mkdir -p "${dest}"
	fi
	shift
	mv ${@} "${dest}/"
}
