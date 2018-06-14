# shellcheck disable=SC2148

# Function: m3u2dir()
#
# Description:
#   Copy files from an m3u playlist to the specified folder/volume.
#
# Parameters:
#   $1 - m3u file with list of files to copy.
#   $2 - destination folder to copy to.
#
# Example:
#   m3u2dir <m3u_playlist>
#
function m3u2dir() {
	for line in $(tr '\r' '\n' < "${1}" | tr ' ' '%'); do
		if [[ "${line:0:1}" == "#" ]]; then
			continue
		else
			echo "${line}"
			file=$(echo "${line}" | tr '%' ' ')
			echo "${file}"
			cp "${file}" "${2}"
		fi
	done
}
