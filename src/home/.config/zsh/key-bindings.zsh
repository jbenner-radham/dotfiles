# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# https://wiki.zshell.dev/docs/guides/syntax/bindkey
# https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# `man zshzle`
# `man 5 terminfo`

# Make sure that the terminal is in application mode when zle is active, since
# only then are the values from `$terminfo` are valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }

  function zle-line-finish() {
    echoti rmkx
  }

  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use Emacs key bindings.
bindkey -e

# Use Vi insert mode bindings.
# bindkey -v

# Use Vi command mode bindings.
# bindkey -a

# [Home] ([Fn + Left Arrow] on Mac) - Go to beginning of line.
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi

# [End] ([Fn + Right Arrow] on Mac) - Go to end of line.
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}" end-of-line
  bindkey -M viins "${terminfo[kend]}" end-of-line
  bindkey -M vicmd "${terminfo[kend]}" end-of-line
fi

# [Shift + Tab] - Move through the completion menu backwards.
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] ([Delete] on Mac) - Delete backward.
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# [Delete] ([Fn + Delete] on Mac) - Delete forward.
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl + Delete] ([Fn + Ctrl + Delete] on Mac) - Delete whole forward word.
bindkey '^[[3;5~' kill-word
# bindkey -M emacs '^[[3;5~' kill-word
# bindkey -M viins '^[[3;5~' kill-word
# bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl + Right Arrow] (unavailable on Mac) - Move forward one word.
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word

# [Ctrl + Left Arrow] (unavailable on Mac) - Move backward one word.
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# [Esc + W] - Kill from the cursor to the mark.
bindkey '\ew' kill-region

# [Esc + L] - Run the command: `la`.
bindkey -s '\el' 'la\n'

# [Ctrl + R] - Search backward incrementally for a specified string. The string
# may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

# [Space] - Don't do history expansion.
bindkey ' ' magic-space

# [Ctrl + X] > [Ctrl + E] - Edit the current command line in `$VISUAL` or
# `$EDITOR` if the former is unset.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# [Esc + M] - Duplicate previous word.
bindkey "^[m" copy-prev-shell-word
