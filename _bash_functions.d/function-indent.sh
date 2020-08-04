# shellcheck disable=SC2148,SC2068

# Function: my_c_indent()
#
# Description:
#   Rewrite C source file following my personal code style.
#
# Parameters:
#   $1 - Indentation size to use
#   $2 - Maximum number of columns in the editor
#   $3 - The C source file to change indentation style.
#
# Example:
#   my_c_indent 4 132 <file.c>
#
function my_c_indent() {
    local indent=${1:-4}; shift
    local width=${1:-80}; shift
    # Find the proper indent cmd to run
    if [[ -n "$(command -v gindent)" ]]; then
        local INDENT=gindent
    else
        local INDENT=indent
    fi

    # Run the indent command with the following paramenters
    ${INDENT} -bad -bap -br -nce -cdw  -npcs -npsl -ncs -nbs -saf -sai -saw -nbc -brf -brs -nut -ts${indent} -i${indent} -l${width} ${@}
}
