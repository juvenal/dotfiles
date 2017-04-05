#! /bin/bash
#
#
#
#
#
#
#
#

# /usr/bin/osascript -e 'do shell script "ls -alF /" with administrator privileges'

function list_versions() {
	echo "Installed RenderMan Pro Server versions:"
	for version in /Applications/Pixar/RenderManProServer*; do
		echo -en "    - "$(basename "${version}")"\n"
	done
}

function use_version() {
	local version=${1}
	sudo sh -c '
	for folder in /Applications/Pixar/RenderManProServer-'${version}'/*; do
		if [[ -d ${folder} ]]; then
			rm /usr/local/prman/$(basename ${folder})
			ln -s ${folder} /usr/local/prman/$(basename ${folder})
		fi
	done
	'
}

command=${1}

if [[ "${command}" == "list" ]]; then
	list_versions
fi

if [[ "${command}" == "use" ]]; then
	vernum=${2}
	use_version ${vernum}
fi
