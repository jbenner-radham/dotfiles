# Based on: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh

# Directory Options <https://zsh.sourceforge.io/Doc/Release/Options.html#Changing-Directories>
setopt AUTO_CD            # Type directory name to cd into it..
setopt AUTO_PUSHD         # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS  # Don’t push multiple copies of the same directory onto the directory stack.

# Directory Navigation Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
