#!/bin/bash

if [[ ! -n "${1}" ]]; then
    echo "You must specify a host."
    exit 1
fi

IBM_MAIL=juvenalj@br.ibm.com
HOST="${1}"
HOSTNAME=$(grep ${1} ~/.ssh/config | grep HostName | awk '{print $2}')
if [ "x${HOSTNAME}" = "x" ]; then
    echo "There is no host called ${HOST} on your SSH config file."
    echo "Trying ${HOST} directly..."
    HOSTNAME=${HOST}
fi

echo -n "Type your intranet password:"
read -s IBM_PASSWD
echo

# Normalize the password special ampersand
IBM_PASSWD=${IBM_PASSWD//\&/\%26}

curl https://${HOSTNAME}:443/ -s -k -o - \
    -d "au_pxytimetag=$(date +%s)&uname=${IBM_MAIL}&pwd=${IBM_PASSWD}&ok=OK" \
    | sed -e 's:.*<H1>::g' -e 's:</H1>.*::g' -e 's:<[^>]*>:\n:g' \
    | head -n 3
