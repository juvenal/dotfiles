#
# shellcheck disable=SC2148
#

# Airport check shortcut
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Launch services register system
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/Current/Frameworks/LaunchServices.framework/Versions/Current/Support/lsregister'
alias rebuild='lsregister -kill -r -domain local -domain system -domain user'

# Time Machine backup file controls and check
alias tm_add='xattr -d com.apple.metadata:com_apple_backup_excludeItem'
alias tm_remove='xattr -w com.apple.metadata:com_apple_backup_excludeItem com.apple.backupd'
alias tm_check='tmutil isexcluded'
