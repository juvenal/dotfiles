#!/bin/bash

if [[ -d /Applications/Pixie ]]; then
	# Define Pixie root path
	export PIXIEHOME=/Applications/Pixie

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

	if [[ -n ${MANPATH} ]]; then
		export MANPATH=${PIXIEHOME}/man:${MANPATH}
	fi

	export PATH=${PIXIEHOME}/bin:${PATH}
fi
