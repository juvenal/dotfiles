# shellcheck disable=SC2148

# Aqsis Rendering Engine configuration include

if [[ -d /Applications/Aqsis.app ]]; then
	# Define Aqsis root path
	export AQSISHOME=/Applications/Aqsis.app

	# Set remaining environment
	export PATH=${AQSISHOME}/Contents/Resources/bin:${PATH}
fi
