# shellcheck disable=SC2148

# Function: randpwd()
#
# Description:
#   Generate a random password
#
# Parameters:
#   $1 - type of chars in password
#        (A = Alpha only, B = A + Numeric, C = B + special)
#   $2 - desired password size (minimum size is 4, if invalid or undefined, assumed 12)
#
# Example:
#   randpwd <passwd_type> <passwd_size>
#
function randpwd() {
    # Set the standard selections
	case ${1} in
		-A) local passwdChars='qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-B) local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-C) local passwdChars='12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-[0-9]*) local passwdSize=${1#-};;
	esac
	case ${2} in
		-A) local passwdChars='qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-B) local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-C) local passwdChars='12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB';;
		-[0-9]*) local passwdSize=${2#-};;
    esac
    # Sanitize required values
    [[ -n ${passwdChars} ]] || \
        local passwdChars='12345qwertQWERTasdfgASDFGzxcvbZXCVB'
    [[ -n ${passwdSize} ]] || \
        local passwdSize=12
    # Generate password
	cat /dev/urandom | \
	LC_CTYPE=C tr -dc ${passwdChars} | \
	head -c${passwdSize}
	echo ""
}
