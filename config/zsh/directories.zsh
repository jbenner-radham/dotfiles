# Directory Options <https://zsh.sourceforge.io/Doc/Release/Options.html#Changing-Directories>
setopt AUTO_CD            # If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt AUTO_PUSHD         # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS  # Don’t push multiple copies of the same directory onto the directory stack.

# Directory Navigation Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'

# List Directory Aliases
if (( $+commands[eza] )); then
  alias la="eza --almost-all --git --group-directories-first --icons --long"
  alias ll="eza --git --group-directories-first --icons --long"
  alias ls="eza --icons"
else
  alias la='ls --color=auto -lAh'
  alias ll='ls --color=auto -lh'
  alias ls='ls --color=auto'
fi
