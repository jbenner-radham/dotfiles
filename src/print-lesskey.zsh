#!/usr/bin/env zsh

cat -v << EOF
#env

# Configure text styling when using \`less\` as a man pager.
# See: \`man 5 terminfo\` (search "TCap Code" e.g., mb, md, etc.)

# The \`tput setaf %d\` command sets the foreground color based upon the
# provided number which can be looked up in the following table:
#
# | Color   | Value |
# |---------|-------|
# | Black   | 0     |
# | Red     | 1     |
# | Green   | 2     |
# | Yellow  | 3     |
# | Blue    | 4     |
# | Magenta | 5     |
# | Cyan    | 6     |
# | White   | 7     |

# Turn on blinking.
LESS_TERMCAP_mb = $(tput blink)

# Turn on bold (extra bright) mode.
LESS_TERMCAP_md = $(tput bold; tput setaf 2) # Bold green.

# Turn off all attributes.
LESS_TERMCAP_me = $(tput sgr0)

# Turn on half-bright mode.
LESS_TERMCAP_mh = $(tput dim)

# Turn on reverse video mode.
LESS_TERMCAP_mr = $(tput rev) # Invert colors.

# Exit standout mode.
LESS_TERMCAP_se = $(tput rmso; tput sgr0)

# Begin standout mode.
LESS_TERMCAP_so = $(tput bold; tput setaf 3) # Bold yellow.

# Exit underline mode.
LESS_TERMCAP_ue = $(tput rmul; tput sgr0)

# Begin underline mode.
LESS_TERMCAP_us = $(tput smul; tput bold; tput setaf 1) # Underlined bold red.
EOF
