# shellcheck disable=SC2148

# Function: sbt()
#
# Description:
#   Activate Sublime Text 3 by the command line (CLI).
#
# Parameters:
#   $@ - All possible parameters are filenames/folders to open.
#
# Example:
#   sbt <file> [...]
#
function sbt() {
	open -a "Sublime Text" "${@}"
}
