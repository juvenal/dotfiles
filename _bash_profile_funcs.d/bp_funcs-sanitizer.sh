#
# shellcheck disable=SC2046,SC2086,SC2148

# Pathset utility functions


# Path sanitizer
#
#
#
function __pathlist_sanitizer() {
    local dir
    local new_pathlist=""
    while read -r -d: dir; do
        if [[ "${dir}" == /* ]]; then
            if [[ -d "${dir}" ]] && [[ ":${new_pathlist}:" != *":${dir}:"* ]]; then
                new_pathlist="${new_pathlist:+"${new_pathlist}:"}${dir}"
            fi
        fi
    done <<< "${1}"
    echo "${new_pathlist}"
}


# Path prepend
#
#
#
function __pathlist_prepend() {
    local path="${1}"
    local pathlist="${2}"
    if [[ "${path}" == /* ]] && [[ -d "${path}" ]]; then
        echo "${path}:${pathlist/":${path}"}"
    else
        echo "${pathlist}"
    fi
}


# Path append
#
#
#
function __pathlist_append() {
    local path="${1}"
    local pathlist="${2}"
    if [[ "${path}" == /* ]] && [[ -d "${path}" ]]; then
        echo "${pathlist/":${path}"}:${path}"
    else
        echo "${pathlist}"
    fi
}


# Base paths' settings
#
#
#
#
function __setpaths() {
    local path=/usr/local/bin:/usr/bin:/bin
    local manpath=/usr/share/man:/usr/local/share/man
    if [[ $(/usr/bin/id -u) -eq 0 ]]; then
        path=$(__pathlist_prepend /sbin "${path}")
        path=$(__pathlist_prepend /usr/sbin "${path}")
        path=$(__pathlist_prepend /usr/local/sbin "${path}")
    else
        path=$(__pathlist_append /usr/local/sbin "${path}")
        path=$(__pathlist_append /usr/sbin "${path}")
        path=$(__pathlist_append /sbin "${path}")
    fi
    echo "PATH=$(__pathlist_sanitizer "${path}"); export PATH;"
    echo "MANPATH=$(__pathlist_sanitizer "${manpath}"); export MANPATH;"
}
