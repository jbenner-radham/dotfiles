# Uncomment this and the `zprof` invocation at the bottom of this file to enable
# profiling.
# Note: This needs to be at the top of the file.
# zmodload zsh/zprof

# Input/Output Options
# See: <https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput>
unsetopt SHORT_LOOPS # Short loops limit the parser's ability to detect errors.

# Since `.zprofile` doesn't appear to be loaded on Ubuntu init Homebrew here.
if [[ "$(uname)" = 'Linux' ]] &&
  [[ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Ensure the XDG runtime directory exists and has the appropriate permissions.
if [[ -n "${XDG_RUNTIME_DIR}" ]]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
  chmod 700 "${XDG_RUNTIME_DIR}"
fi

# The parenthesized characters are called glob qualifiers and do the following:
#  .: Match only plain files.
#  N: Set the `NULL_GLOB` option for the current pattern. This will suppress the
#     error raised when no files match the current pattern.
#  r: Match only owner-readable files.
# See: <https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers>
# Note: The glob won't work if it's quoted.
for file in $XDG_CONFIG_HOME/zsh/*.zsh(.Nr); do
  source "${file}"
done

# Unset our loop variable so it doesn't persist in our shell session.
unset file

# Setup
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[sheldon] )) && eval "$(sheldon source)"
(( $+commands[starship] )) && eval "$(starship init zsh)"

# A Little Fun
(( $+commands[cowsay] )) && (( $+commands[fortune] )) && cowsay "$(fortune)"

# Uncomment this and the `zmodload zsh/zprof` invocation at the top of this file
# to enable profiling.
# Note: This needs to be at the bottom of the file.
# zprof
