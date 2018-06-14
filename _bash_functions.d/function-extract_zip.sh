# shellcheck disable=SC2148

# Function: extract_zip()
#
# Description:
#   Extract the content of a ZIP archive.
#
# Parameters:
#   $1 - Pathname of ZIP archive to extract.
#
# Example:
#   extract_zip <zipfile>
#
function extract_zip() {
	if [[ -f "${1}" ]]; then
		origdir="$(echo "${1%%.zip}" | tr ' ' '_' | tr "[:upper:]" "[:lower:]")"
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
		unzip ../"${1}"
		popd > /dev/null
	else
		echo "Archive not found... Skipping"
	fi
}
