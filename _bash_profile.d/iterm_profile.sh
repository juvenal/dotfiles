# shellcheck disable=SC2148

# Check for iTerm before running its integration (macOS specific)
[[ "${TERM_PROGRAM}" == "iTerm.app" ]] && \
	[[ -e "${HOME}/.iterm2_shell_integration.bash" ]] && \
		source "${HOME}/.iterm2_shell_integration.bash"
