#!/bin/bash
#
#
#
#
#
#
#
#
#
#
#
#

# Some config info for the sessions
SESSIONS="config-vms development projects blogs"
WINDOWS0="main connections vm-host tests"
WINDOWS1="main at-build toolchain intel_tbb workspace1 workspace2 workspace3"
WINDOWS2="main easycapviewer simplecomic bookshelf chmox gitifyhg MEGA"
WINDOWS3="main v2-labs juvenal thoughts que-pais-eh-esse"
#if [[ -z ${1} ]]; then
	DEFAULT="development"
#else
#	session=$(echo ${SESSIONS} | grep "${1}")
#fi;

# Set tmux install path from custom brew...
tmux="${HOME}/.local/bin/tmux"
# Check and create the sessions and windows when necessary
SESSION_ID=0
for SESSION in ${SESSIONS}; do
	${tmux} has-session -t ${SESSION} > /dev/null 2>&1
	if [[ ${?} -ne 0 ]]; then
		WINDOWS=$(eval "echo \$(echo "\$WINDOWS${SESSION_ID}")")
		WINDOW_ID=0
		for WINDOW in ${WINDOWS}; do
			if [[ ${WINDOW_ID} -eq 0 ]]; then
				${tmux} new-session -s ${SESSION} -n ${WINDOW} -d
			else
				${tmux} new-window -n ${WINDOW} -t ${SESSION}
			fi
			WINDOW_ID=$(( ${WINDOW_ID} + 1 ))
		done
		${tmux} select-window -t ${SESSION}:1
	fi
	SESSION_ID=$(( ${SESSION_ID} + 1 ))
done
# Attach the default session
${tmux} attach -t ${DEFAULT}
