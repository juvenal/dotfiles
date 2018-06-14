#
# shellcheck disable=SC2148

# Pathset utility functions

# Path sanitizer
#
#
#
function __pathlist_sanitizer() {
    local new_pathlist=""
    local dir
    while read -r -d: dir; do
        if [[ ${dir} == /* ]]; then
            if [[ -d "${dir}" ]] && [[ ":${PATH}:" != *":${dir}:"* ]]; then
                new_pathlist="${new_pathlist}:${dir}"
            fi
        fi
    done <<< "${1}:"
    echo "${new_pathlist#:}"
}


# Path prepend
#
#
#
function __pathlist_prepend() {
    local path=${2}
    local pathlist=${1}
    if [[ ${path} == /* ]] && [[ -d "${path}" ]]; then
        echo "${path}:${pathlist/:${path}}"
    else
        echo "${pathlist}"
    fi
}


# Path append
#
#
#
function __pathlist_append() {
    local path=${2}
    local pathlist=${1}
    if [[ ${path} == /* ]] && [[ -d "${path}" ]]; then
        echo "${pathlist/:${path}}:${path}"
    else
        echo "${pathlist}"
    fi
}
