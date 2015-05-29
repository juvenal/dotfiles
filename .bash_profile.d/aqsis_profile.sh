#! /usr/bash

if [[ -d /Applications/Aqsis.app ]]; then
	# Define Aqsis root path
	export AQSISHOME=/Applications/Aqsis.app

	# Set remaining environment
	export PATH=${AQSISHOME}/Contents/Resources/bin:${PATH}
fi
