# Sudo
alias sudo='sudo ' # Allow `sudo` to work with aliases.

# List Directory Aliases
if (( $+commands[eza] )); then
  alias la='eza --almost-all --git --group-directories-first --icons --long'
  alias ll='eza --git --group-directories-first --icons --long'
  alias ls='eza --icons'
else
  alias la='ls --color=auto -lAh'
  alias ll='ls --color=auto -lh'
  alias ls='ls --color=auto'
fi

# Pretty Bat (from bat-extras)
if (( $+commands[prettybat] )); then
  alias pbat='prettybat'
fi

# Pretty Print Environment Variables
alias penv='print -ol $(env)'

# Pretty Print Path
alias ppath='print -l ${path}'
