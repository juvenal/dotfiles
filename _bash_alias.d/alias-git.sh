#
# shellcheck disable=SC2148
#

# Verify GIT projects that need a fetch
alias git_check='for PRJ in $(ls *); do if [[ -d ${PRJ} ]]; then pushd ${PRJ} > /dev/null; if [[ ! -d .git ]]; then echo "Projeto ${PRJ} is not a git repo"; fi; popd > /dev/null; fi; done;'
