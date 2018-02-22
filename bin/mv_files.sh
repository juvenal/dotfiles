#!/bin/bash
#
#
#
#

#
src_root="${1}"
dest_root="${2}"

#
while IFS= read -r -d '' file; do
	dest_file=$(basename "${file}")
	echo "Moving file ${file} to ${dest_root}/${dest_file}"
	mv "${file}" "${dest_root}/${dest_file}"
	if [[ ${?} -ne 0 ]]; then
		exit 1
	fi
done < <(find "${src_root}" -type f -print0)
