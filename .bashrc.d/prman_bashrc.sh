#! /usr/bash

if [[ -d /usr/local/prman ]]; then
	# Define Pixar RenderMan Pro Server 19(+) root path
	export RMANTREE=/usr/local/prman

	# Set remaining environment
	export PATH=${RMANTREE}/bin:${PATH}
fi
