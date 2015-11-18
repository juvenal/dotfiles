#!/bin/bash

# Small functions
# ===============
#
# This config files contains some small functions to be integrated into the
# current shell. They should be small functions used to provide housekeeping
# of your environment.

# Funtion: not_there()
#
# Description:
#   List files of some path that are not in a given filelist
#
# Parameters:
#   $1 - Path to search in
#   $2 - Path of text filelist
#
# Example:
#   .
#
function not_there() {
	for FILE in $(cd "${1}" && find . ! -path . -print | sed -r 's|^\.\/||g'); do
		if ! grep -e "^${FILE}$" "${2}" > /dev/null 2>&1; then
			echo "${FILE}"
		fi
	done
}

# Funtion: record()
#
# Description:
#   Start logging terminal output.
#
# Parameters:
#   none.
#
# Example:
#   .
#
function record() {
	if [[ ! -s "${HOME}/Documents/ShellLogs" ]]; then
		mkdir "${HOME}/Documents/ShellLogs/"
	fi
	script -a "${HOME}/Documents/ShellLogs/ScriptSession-$(date "+%m-%d-%y %H;%M.%S").log"
}

# Funtion: mkcd()
#
# Description:
#   Create folder and change to it.
#
# Parameters:
#   $1 - folder name to create.
#
# Example:
#   .
#
function mkcd() {
	mkdir -p "${*}"
	cd "${*}"
}

# Funtion: mksel()
#
# Description:
#   Move selection to a (new) folder.
#
# Parameters:
#   $1 - Pathname of new directory/folder to create.
#   $2 - In fact, remaining parameters are filenames to move into $1.
#
# Example:
#   .
#
function mksel() {
	dest="${1}"
	if [[ -d "${dest}" ]]; then
		mkdir "${dest}"
	fi
	shift
	mv "${@}" "${dest}/"
}

# Funtion: sbt()
#
# Description:
#   Activate Sublime Text 3 by the command line (CLI).
#
# Parameters:
#   $@ - All possible parameters are filenames/folders to open.
#
# Example:
#   .
#
function sbt() {
	open -a "Sublime Text" "${@}"
}

# Funtion: m3u2dir()
#
# Description:
#   Copy files from an m3u playlist to the specified folder/volume.
#
# Parameters:
#   $1 - m3u file with list of files to copy.
#   $2 - destination folder to copy to.
#
# Example:
#   .
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

# Funtion: bso()
#
# Description:
#   Open BSO firewall for given network servers.
#
# Parameters:
#   none.
#
# Example:
#   .
#
function bso() {
	# Set your credentials
	IBM_MAIL=juvenalj@br.ibm.com
	# Ask for your password only once
	echo -n "Type your intranet password: "
	read -s IBM_PASSWD
	echo
	# Cycle thru servers
	while IFS= read -r server; do
		# Try to expand any host nickname on .ssh/config
		HOST="${server}"
		HOSTNAME=$(grep "${server}" ~/.ssh/config | grep HostName | awk '{print $2}')
		if [[ "x${HOSTNAME}" == "x" ]]; then
			# There is no host called ${HOST} on your SSH config file.
			# Trying ${HOST} directly
			HOSTNAME=${HOST}
		fi
		# Check its BSO clearance on given host network
		bso_active=$(curl https://"${HOSTNAME}":443/ -s -k -o - | grep -o 'Firewall')
		if [[ "${bso_active}" == "Firewall" ]]; then
			# Perform domain clearance if needed...
			request=$(curl https://"${HOSTNAME}":443/ -s -k -o - \
						-d "au_pxytimetag=$(date +%s)&uname=${IBM_MAIL}&pwd=${IBM_PASSWD}&ok=OK" \
						| sed -e 's:.*<H1>::g' -e 's:</H1>.*::g' -e 's:<[^>]*>:\n:g' \
						| head -n 3 | grep -o "BSO Authentication Successfull")
			if [[ "${request}" == "BSO Authentication Successfull" ]]; then
				echo "Host ${HOSTNAME} cleared"
			else
				echo "Host ${HOSTNAME} denied access"
			fi
		else
			echo "Host ${HOSTNAME} already opened"
		fi
	done < <(grep -v "^ #*" ~/.bso_servers)
}


# Funtion: extract_rar()
#
# Description:
#   Extract the content of a RAR archive.
#
# Parameters:
#   $1 - Pathname of RAR archive to extract.
#
# Example:
#   .
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


# Funtion: extract_zip()
#
# Description:
#   Extract the content of a ZIP archive.
#
# Parameters:
#   $1 - Pathname of ZIP archive to extract.
#
# Example:
#   .
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
