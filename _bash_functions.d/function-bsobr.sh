# Function: bsobr()
#
# Description:
#   Open BSO firewall for Brazil Lab.
#
# Parameters:
#   none.
#
# Example:
#   bsobr
#
function bsobr() {
    local username='juvenalj@br.ibm.com'
    local password;
    local rc;

    local url_step_1='https://9.86.37.75/netaccess/connstatus.html'
    local url_step_2='https://9.86.37.75/netaccess/loginuser.html'

    read -s -p 'IBM Intranet Password: ' password
    echo

    curl ${url_step_1} \
         --silent \
         --insecure \
         --location \
         --data-urlencode 'sid=0' \
         --data-urlencode 'login=Log In Now' | \
            grep -q 'LTC-Lab Boundary Firewall: Enter your IBM Intranet credentials'

    rc=${?}
    echo -n 'Step 1/2 (init): '
    [[ ${rc} -eq 0 ]] && echo 'PASS' || echo 'FAIL'

    curl ${url_step_2} \
         --silent \
         --insecure \
         --location \
         --data-urlencode 'sid=0' \
         --data-urlencode "username=${username}" \
         --data-urlencode "password=${password}" | \
            grep -q 'BSO Authentication Successful'

    rc=${?}
    echo -n 'Step 2/2 (auth): '
    [[ ${rc} -eq 0 ]] && echo 'PASS' || echo 'FAIL'
}
