# History Options <https://zsh.sourceforge.io/Doc/Release/Options.html#History>
setopt EXTENDED_HISTORY        # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt HIST_EXPIRE_DUPS_FIRST  # If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list.
# setopt HIST_IGNORE_ALL_DUPS    # If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_DUPS        # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_SPACE       # Remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space.
# setopt HIST_SAVE_NO_DUPS       # When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_VERIFY             # Whenever the user enters a line with history expansion, don’t execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
# setopt INC_APPEND_HISTORY      # This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits.
setopt SHARE_HISTORY           # This option both imports new commands from the history file, and also causes your typed commands to be appended to the history file.
