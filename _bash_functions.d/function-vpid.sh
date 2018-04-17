# Function: vpid()
#
# Description:
#   List all process descriptors for a given process name (case insensitive)
#
# Parameters:
#   $1 - The process name list
#
# Example:
#   vpid <name_of_command>
#
function vpid() {
	ps ax | grep -i ${1} | grep -v 'grep'
}
