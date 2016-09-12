#!/bin/bash
#
#
#
#

# Check required parameter
arch_type="${1}"
if [[ -z "${arch_type}" ]]; then
	echo "You must inform the type of archive to expand. Currently supported"
	echo "ones are 'zip' and 'rar'."
	exit 1
elif [[ "${arch_type}" != "zip" && "${arch_type}" != "rar" ]]; then
	echo "Unsupported archive format... Use 'zip' or 'rar' only."
	exit 1
fi

# Load required functions, if not defined yet...
if [[ "$(type -t extract_zip)x" == "x" && \
	  "$(type -t extract_rar)y" == "y" ]]; then
	source ~/.bash_functions
fi

# Remove old logs
rm -rf ./expanded.log

# Run expand on requested archives found
set +e
for archfile in *.${arch_type}; do
	{
		echo "*** Expanding ${archfile}"
		"extract_${arch_type}" "${archfile}"
		dropbox_uploader upload "${archfile}" "Archives/eBooks/Originals/${archfile}"
		if [[ ${?} -eq 0 ]]; then
			rm -rf "${archfile}"
		else
			exit 1
		fi
	} >> ./expanded.log 2>&1
done
set -e
