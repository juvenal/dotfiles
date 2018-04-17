# Function: extract_rar()
#
# Description:
#   Extract the content of a RAR archive.
#
# Parameters:
#   $1 - Pathname of RAR archive to extract.
#
# Example:
#   extract_rar <rarfile>
#
function extract_rar() {
	if [[ -f "${1}" ]]; then
		origdir="$(echo "${1%%.rar}" | tr ' ' '_' | tr "[:upper:]" "[:lower:]")"
		namedir="${origdir}"
		while [[ -d "${namedir}" ]]; do
			namedir+="_"
		done
		if [[ "${origdir}" != "${namedir}" ]]; then
			mv "${origdir}" "${namedir}"
		fi
		mkdir "${origdir}"
		pushd ./"${origdir}" > /dev/null
		echo "Expanding ${1} into ${origdir}"
		rar x ../"${1}"
		popd > /dev/null
	else
		echo "Archive not found... Skipping"
	fi
}
