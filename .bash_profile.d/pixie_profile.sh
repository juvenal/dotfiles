#! /usr/bash

if [[ -d /usr/local/Pixie ]]; then
	# Define Pixie root path
	export PIXIEHOME=/usr/local/Pixie

	# Set remaining environment
	if [[ -n ${DISPLAYS} ]]; then
		export DISPLAYS=.:${PIXIEHOME}/displays:${DISPLAYS}
	else
		export DISPLAYS=.:${PIXIEHOME}/displays
	fi

	if [[ -n ${SHADERS} ]]; then
		export SHADERS=.:${PIXIEHOME}/shaders:${SHADERS}
	else
		export SHADERS=.:${PIXIEHOME}/shaders
	fi

	if [[ -n ${DYLD_LIBRARY_PATH} ]]; then
		export DYLD_LIBRARY_PATH=${PIXIEHOME}/lib:${DYLD_LIBRARY_PATH}
	else
		export DYLD_LIBRARY_PATH=${PIXIEHOME}/lib
	fi

	export PATH=${PIXIEHOME}/bin:${PATH}
fi
