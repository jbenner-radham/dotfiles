# Based on: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh

# Should be called before compinit(?)
zmodload zsh/complist

# Reference: https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#kill-word-or-backward-kill-word-do--dont-delete-a-symbol-wordchars
WORDCHARS=''

# Input/Output Options <https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput>
unsetopt FLOW_CONTROL    # If this option is unset, output flow control via start/stop characters is disabled in the shell’s editor.

# Completion Options <https://zsh.sourceforge.io/Doc/Release/Options.html#Completion-4>
unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.
setopt ALWAYS_TO_END     # If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word.
setopt AUTO_MENU         # Show completion menu on successive tab press.
setopt COMPLETE_IN_WORD  # If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.

# Should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# Disable named-directories autocompletion.
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are usable.
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Automatically load bash completion functions.
autoload -U +X bashcompinit && bashcompinit
