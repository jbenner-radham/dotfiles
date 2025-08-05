# Input/Output Options <https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput>
unsetopt SHORT_LOOPS # Short loops limit the parser's ability to detect errors.

# See: https://www.freedesktop.org/software/systemd/man/latest/file-hierarchy.html#Home%20Directory
local -r local_bin_dir="${HOME}/.local/bin"

if (( ! $path[(Ie)$local_bin_dir] )) && [[ -d "${local_bin_dir}" ]]; then
  # Since $path is being used as an array-like here don't quote it!
  path=("${local_bin_dir}" $path)
  export PATH
fi

# The parenthesized characters are called glob qualifiers and do the following:
#  .: Match only plain files.
#  N: Set the `NULL_GLOB` option for the current pattern. This will suppress the
#     error raised when no files match the current pattern.
#  r: Match only owner-readable files.
# See: <https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers>
for file in $XDG_CONFIG_HOME/zsh/*.zsh(.Nr); do
  source $file
done

# Reference: <https://thevaluable.dev/zsh-completion-guide-examples/#enabling-the-zsh-completion-system>
autoload -Uz compinit && compinit

# Setup
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(sheldon source)"
