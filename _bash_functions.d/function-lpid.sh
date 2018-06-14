# shellcheck disable=SC2148

# Function: lpid()
#
# Description:
#   List all process_id of a given process name (case insensitive)
#
# Parameters:
#   $1 - The process name list associated PIDs
#
# Example:
#   lpid <name_of_command>
#
function lpid() {
	ps ax | grep -i ${1} | grep -v 'grep' | sed 's/^ *//' | cut -f 1 -d " "
}
