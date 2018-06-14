#
# shellcheck disable=SC2148
#

# Only define swift as an alias on early swift versions
[[ -z "$(command -v swift)" ]] && alias swift='lldb --repl'

# Some usefull docker aliases (if docker installed)
if [[ -n "$(command -v docker)" ]]; then
	alias swift3_linux="docker run --cap-add sys_ptrace -it --rm swift swift"
fi
