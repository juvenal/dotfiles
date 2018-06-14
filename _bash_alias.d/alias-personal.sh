#
# shellcheck disable=SC2148
#

# Shortcut to get up one folder level
alias ..='cd ..'

# Some additional aliases for 'ls'
alias l='ls -CF'
alias ll='ls -l'
alias la='ll -A'
alias lr='ll -tr'
alias lla='ls -al'
alias df='df -h'
alias du='du -h'
alias dir='ls -l'
alias vdir='ls -l'
alias ltr='ls -ltr'
alias ltra='ls -altr'

# Some quick one liner to create directories inside protected areas
alias pmkdir='sudo install -o $(id -u) -g $(id -g) -d'
