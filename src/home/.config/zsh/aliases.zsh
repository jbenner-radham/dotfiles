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

# Bat (if `bat` is installed via `apt` on Ubuntu it is installed as `batcat`)
if (( $+commands[batcat] )); then
  alias bat='batcat'
fi

# Neovim Man Pager
if (( $+commands[nvim] )); then
  # Not nicely colorized like `less`, but worth it just for the `gO` command.
  alias nman='MANPAGER="nvim +Man!" man'
fi

# Pretty Bat (from bat-extras)
if (( $+commands[prettybat] )); then
  alias pbat='prettybat'
fi

# Pretty Print Path
alias ppath='print -l ${path}'

# Wget (run without creating a `${HOME}/.wget-hsts` file)
if (( $+commands[wget] )); then
  alias wget='wget --hsts-file=/dev/null'
fi
