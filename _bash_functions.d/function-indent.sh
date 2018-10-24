# shellcheck disable=SC2148

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
	# Run the indent command with the following paramenters
	indent -bad -bap -br -nce -cdw  -npcs -npsl -ncs -nbs -saf -sai -saw -nbc -brf -brs -nut -ts${1} -i${1} -l${2} ${3};
}
