# shellcheck disable=SC2148

# Function: bash_fork()
#
# Description:
#   Start the given process in the background, creating a log file and a
#   PID file to identify the running process.
#
# Parameters:
#   $1 - The process name to be executed
#
# Example:
#   bash_fork <name_of_command>
#
function bash_fork() {
	# Identify the process name
	local process_name=${1}

	# Set the logdir pathname and date time
	local dtnow="$(date "+%Y-%m-%d %H:%M:%S")"
	local logdir="${HOME}/.local/var/log"
	local piddir="${HOME}/.local/var/run"

	# Set the logdir/piddir if non existent
	[[ -d "${logdir}" ]] || mkdir -p "${logdir}"
	[[ -d "${piddir}" ]] || mkdir -p "${piddir}"

	# Define the log/pid filenames to store
	local process_log="${logdir}/$(basename "${process_name}").log"
	local process_pid="${piddir}/$(basename "${process_name}").pid"

	# Check for $process_pid file/process existence
	if [[ -f ${process_pid} ]] && pgrep -F "${process_pid}" > /dev/null 2>&1; then
		echo "[Information]: Aborted startup of process ${1}, already running at pid $(cat "${process_pid}")" >> "${process_log}"
	else
		# If process_log does exist, add a section separator
		[[ -f ${process_log} ]] && \
			echo -e "\n**************************" >> "${process_log}"

		# Signal the start process
		echo "Starting process '${1}' at ${dtnow}." >> "${process_log}"
		echo "- Command used: ${*}" >> "${process_log}"

		# Perform the fork logging the output
		("${@}" >> "${process_log}" 2>&1 &
		 echo "${!}" > "${process_pid}")
	fi
}
