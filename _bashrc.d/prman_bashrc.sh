# shellcheck disable=SC2148

# Pixar RenderMan Rendering Engine configuration include

if [[ -d /usr/local/prman ]]; then
	# Define Pixar RenderMan Pro Server root path
	export RMANTREE=/usr/local/prman

	# Set remaining environment
	export PATH=${RMANTREE}/bin:${PATH}
fi
