# Function: atom()
#
# Description:
#   Activate Atom by the command line (CLI).
#
# Parameters:
#   $@ - All possible parameters are filenames/folders to open.
#
# Example:
#   atom <file> [...]
#
function atom() {
	open -a "Atom" "${@}"
}
