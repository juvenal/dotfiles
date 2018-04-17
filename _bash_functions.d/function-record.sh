# Function: record()
#
# Description:
#   Start logging terminal output.
#
# Parameters:
#   none.
#
# Example:
#   record
#
function record() {
	if [[ ! -s "${HOME}/Documents/ShellLogs" ]]; then
		mkdir "${HOME}/Documents/ShellLogs/"
	fi
	script -a "${HOME}/Documents/ShellLogs/ScriptSession-$(date "+%m-%d-%y %H;%M.%S").log"
}
