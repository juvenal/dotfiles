# shellcheck disable=SC2148

# Function: crashplan()
#
# Description:
#   Opens a SSH tunnel to the headless crashplan server, update the local
#   connection token file, and starts the desktop client.
#   It tries to load some config vars on ~/.crashplan_data.
#
# Parameters:
#   - Host to connect (optional)
#
# Example:
#   crashplan
#
function crashplan() {
    # Check for crashplan configutation vars
    if [[ -f ~/.crashplan_data ]]; then
        source ~/.crashplan_data
    fi

    local LOCALPORT=4200
    local USER="${CRASHPLAN_USER}"
    if [[ -z "${1}" ]]; then
        local HOST="${CRASHPLAN_HOST}"
    else
        local HOST="${1}"
    fi
    local PORT=$(cut -f 1 -d ',' "${CRASHPLAN_INFO}/.ui_info")
    if [[ "${PORT}" != "${LOCALPORT}" ]]; then
        mv -f "${CRASHPLAN_INFO}/.ui_info" "${CRASHPLAN_INFO}/.ui_info.local"
    fi
    ui_info=($(ssh ${USER}@${HOST} "cat /var/lib/crashplan/.ui_info" | sed -e 's/,/ /g'));

    echo "${LOCALPORT},${ui_info[1]},${ui_info[2]}" > "${CRASHPLAN_INFO}/.ui_info"
    ( (sleep 3 && open "/Applications/CrashPlan.app")& )
    ssh -L ${LOCALPORT}:localhost:${ui_info[0]} ${USER}@${HOST} -Nv
}
