#!/bin/bash
#
#
#
#

# Setup the logfile to use
log="$(pwd)/moveup.log"
flog="${log}"
while [[ -f "${flog}" ]]; do
	flog+="_"
done
if [[ "${log}" != "${flog}" ]]; then
	mv "${log}" "${flog}"
fi

# Prepare the safeguard place
garbage="$(pwd)/.trashing"
[[ -d "${garbage}" ]] || mkdir -p "${garbage}"

# Working on files...
while IFS= read  -r -d '' folder; do
	{
		# Perform the move up of files
		folder=$(basename "${folder}")
		echo "Working on ${folder}."
		pushd "${folder}" > /dev/null
		while IFS= read -r -d '' file; do
			file=$(basename "${file}")
			echo "Moving ${file}."
			ext="${file##*.}"
			name="${file%.*}"
			tname=$(echo "${name}" | sed -E 's/_CODE$//g' | sed -E 's/[0-9]*[X]?//g')
			if [[ -z ${tname} ]]; then
				mv -vf "${file}" "../${folder}_(${name}).${ext}"
			else
				mv -vf "${file}" "../${name}.${ext}"
			fi
			if [[ ${?} -ne 0 ]]; then
				exit 1
			fi
		done < <(find . -type f -depth 1 -print0)
		popd > /dev/null
		mv -vf "${folder}" "${garbage}/"
	}  >> "${log}" 2>&1
done < <(find . -type d -depth 1 -print0)
