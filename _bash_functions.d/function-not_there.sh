# Function: not_there()
#
# Description:
#   List files of some path that are not in a given filelist
#
# Parameters:
#   $1 - Path to search in
#   $2 - Path of text filelist
#
# Example:
#   not_there <searchpath> <filelist_path>
#
function not_there() {
	for FILE in $(cd "${1}" && find . ! -path . -print | sed -r 's|^\.\/||g'); do
		if ! grep -e "^${FILE}$" "${2}" > /dev/null 2>&1; then
			echo "${FILE}"
		fi
	done
}
