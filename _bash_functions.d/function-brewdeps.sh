# shellcheck disable=SC2148

# Function: brewdeps()
#
# Description:
#   Show the list of packages installed with their dependencies
#
# Parameters:
#   none.
#
# Example:
#   brewdeps
#
function brewdeps() {
	brew list | \
	while read cask; do
		printf '\033[38;5;%sm%s ->\033[0m' '34' $cask
		brew deps $cask | awk '{printf(" %s ", $0)}'
		echo ""
	done
}
