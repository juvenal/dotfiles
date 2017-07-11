#!/bin/bash

if [[ -d /Applications/3Delight ]]; then
	# Define the 3DLight root path
	export DELIGHT=/Applications/3Delight

	# Set remaining environment
	if [[ -n $DL_SHADERS_PATH ]]; then
		export DL_SHADERS_PATH=.:${DELIGHT}/shaders:${DL_SHADERS_PATH}
	else
		export DL_SHADERS_PATH=.:${DELIGHT}/shaders
	fi

	if [[ -n $DL_DISPLAYS_PATH ]]; then
		export DL_DISPLAYS_PATH=.:${DELIGHT}/displays:${DL_DISPLAYS_PATH}
	else
		export DL_DISPLAYS_PATH=.:${DELIGHT}/displays
	fi

	if [[ -n $DL_TEXTURES_PATH ]]; then
		export DL_TEXTURES_PATH=.:${DL_TEXTURES_PATH}
	else
		export DL_TEXTURES_PATH=.
	fi

	if [[ -n $INFOPATH ]]; then
		export INFOPATH=${INFOPATH}:${DELIGHT}/doc/info
	else
		export INFOPATH=${DELIGHT}/doc/info
	fi

	if [[ -n $DYLD_LIBRARY_PATH ]]; then
		export DYLD_LIBRARY_PATH=${DELIGHT}/lib:${DYLD_LIBRARY_PATH}
	else
		export DYLD_LIBRARY_PATH=${DELIGHT}/lib
	fi

	if [[ -n $MAYA_RENDER_DESC_PATH ]]; then
		export MAYA_RENDER_DESC_PATH=${DELIGHT}/maya/render_desc:${MAYA_RENDER_DESC_PATH}
	else
		export MAYA_RENDER_DESC_PATH=${DELIGHT}/maya/render_desc
	fi

	export PATH=$DELIGHT/bin:${PATH}
fi
