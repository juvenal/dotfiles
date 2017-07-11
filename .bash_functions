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
#   not_there <searchpath> <filelist_path>
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
#   record
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
#   mkcd <foldername>
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
#   mksel <enclosed_folder> <file> [...]
#
function mksel() {
	dest="${1}"
	if [[ -d "${dest}" ]]; then
		mkdir -p "${dest}"
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
#   sbt <file> [...]
#
function sbt() {
	open -a "Sublime Text" "${@}"
}

# Funtion: atom()
#
# Description:
#   Activate Atom by the command line (CLI).
#
# Parameters:
#   $@ - All possible parameters are filenames/folders to open.
#
# Example:
#   atom <file> [...]
#
function atom() {
	open -a "Atom" "${@}"
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

# Funtion: bso()
#
# Description:
#   Open BSO firewall for given network servers.
#
# Parameters:
#   none.
#
# Example:
#   bso
#
function bso() {
	# Set your credentials
	IBM_MAIL=juvenalj@br.ibm.com
	# Ask for your password only once
	echo -n "Type your intranet password: "
	read -s IBM_PASSWD
	echo
	# Normalize the password special ampersand
	IBM_PASSWD=${IBM_PASSWD//\&/\%26}
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


# Funtion: bsobr()
#
# Description:
#   Open BSO firewall for Brazil Lab.
#
# Parameters:
#   none.
#
# Example:
#   bsobr
#
function bsobr() {
    local username='juvenalj@br.ibm.com'
    local password;
    local rc;

    local url_step_1='https://9.86.37.75/netaccess/connstatus.html'
    local url_step_2='https://9.86.37.75/netaccess/loginuser.html'

    read -s -p 'IBM Intranet Password: ' password
    echo

    curl ${url_step_1} \
         --silent \
         --insecure \
         --location \
         --data-urlencode 'sid=0' \
         --data-urlencode 'login=Log In Now' | \
            grep -q 'LTC-Lab Boundary Firewall: Enter your IBM Intranet credentials'

    rc=${?}
    echo -n 'Step 1/2 (init): '
    [[ ${rc} -eq 0 ]] && echo 'PASS' || echo 'FAIL'

    curl ${url_step_2} \
         --silent \
         --insecure \
         --location \
         --data-urlencode 'sid=0' \
         --data-urlencode "username=${username}" \
         --data-urlencode "password=${password}" | \
            grep -q 'BSO Authentication Successful'

    rc=${?}
    echo -n 'Step 2/2 (auth): '
    [[ ${rc} -eq 0 ]] && echo 'PASS' || echo 'FAIL'
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


# Funtion: extract_zip()
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

# Function: vpid()
#
# Description:
#   List all process descriptors for a given process name (case insensitive)
#
# Parameters:
#   $1 - The process name list
#
# Example:
#   vpid <name_of_command>
#
function vpid() {
	ps ax | grep -i ${1} | grep -v 'grep'
}

# Function: lpid()
#
# Description:
#   List all process_id of a given process name (case insensitive)
#
# Parameters:
#   $1 - The process name list associated PIDs
#
# Example:
#   lpid <name_of_command>
#
function lpid() {
	ps ax | grep -i ${1} | grep -v 'grep' | sed 's/^ *//' | cut -f 1 -d " "
}

# Function: randpwd()
#
# Description:
#   Generate a random password
#
# Parameters:
#   $1 - type of chars in password
#        (A = Alpha only, B = A + Numeric, C = B + special)
#   $2 - desired password size (minimum size is 4, if invalid or undefined, assumed 12)
#
# Example:
#   randpwd <passwd_type> <passwd_size>
#
function randpwd() {
    # Set the standard selections
	case ${1} in
		-A) local passwdChars='qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-B) local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-C) local passwdChars='12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-[456789]) local passwdSize=${1#-};;
	esac
	case ${2} in
		-A) local passwdChars='qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-B) local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-C) local passwdChars='12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-[456789]) local passwdSize=${2#-};;
    esac
    # Sanitize required values
    [[ -n ${passwdChars} ]] || \
        local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB'
    [[ -n ${passwdSize} ]] || \
        local passwdSize=12
    # Generate password
	cat /dev/urandom | \
	LC_CTYPE=C tr -dc ${passwdChars} | \
	head -c${passwdSize}
	echo ""
}

# Function: brewdeps()
#
# Description:
#   Show the list of packages installed with their dependencies
#
# Parameters:
#   none.
#
# Example:
#   brewdeps
#
function brewdeps() {
	brew list | \
	while read cask; do
		printf '\033[38;5;%sm%s ->\033[0m' '34' $cask
		brew deps $cask | awk '{printf(" %s ", $0)}'
		echo ""
	done
}
