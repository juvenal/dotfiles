# Function: bso()
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
