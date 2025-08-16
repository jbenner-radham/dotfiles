#!/usr/bin/env zsh

cat -v << EOF
#env

# Configure text styling when using \`less\` as a man pager.
# See: \`man 5 terminfo\` (search "TCap Code" e.g., mb, md, etc.)

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

# Enter subscript mode.
LESS_TERMCAP_ZN = $(tput ssubm)

# Enter superscript mode.
LESS_TERMCAP_ZO = $(tput ssupm)

# End subscript mode.
LESS_TERMCAP_ZV = $(tput rsubm)

# End superscript mode.
LESS_TERMCAP_ZW = $(tput rsupm)
EOF
