#!/usr/bin/env zsh

# See: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124

# Bold
# tput bold | cat -v
# >>> ^[[1m
#
# Green
# tput setaf 2 | cat -v
# >>> ^[[32m
#
# Bold Green
# (No tput command?)
# >>> ^[[1;32m
#
# Underline
# tput smul | cat -v
# >>> ^[[4m

function print-error() {
  printf '%s%s%s\n' $(tput sgr1) $1 $(tput sgr0) >&2
}

function bold-color-code() {
  zmodload zsh/pcre

  setopt REMATCH_PCRE

  if (( # != 1 )); then
    print-error 'Exactly one color code argument is required.'
    exit 1
  fi

  local -r bold="$(tput bold | cat -v)"
  local -r color="$(tput setaf $1 | cat -v)"
  local -r pattern='(\d+)'
  local bold_digit
  local color_digit

  pcre_compile -smx $pattern
  pcre_match -b -- $bold

  if (( ? == 0 )); then
    bold_digit=$MATCH
  else
    print "no match"
  fi

  pcre_match -b -- $color

  if (( ? == 0 )); then
    color_digit=$MATCH
  else
    print "no match"
  fi

  print "^[[${bold_digit};${color_digit}m"
}

function bold-underline-color-code() {
  zmodload zsh/pcre

  setopt REMATCH_PCRE

  if (( # != 1 )); then
    print-error 'Exactly one color code argument is required.'
    exit 1
  fi

  local -r bold="$(tput bold | cat -v)"
  local -r color="$(tput setaf $1 | cat -v)"
  local -r underline="$(tput smul | cat -v)"
  local -r pattern='(\d+)'
  local bold_digit
  local underline_digit
  local color_digit

  pcre_compile -smx $pattern
  pcre_match -b -- $bold

  if (( ? == 0 )); then
    bold_digit=$MATCH
  else
    print "no match"
  fi

  pcre_match -b -- $underline

  if (( ? == 0 )); then
    underline_digit=$MATCH
  else
    print "no match"
  fi

  pcre_match -b -- $color

  if (( ? == 0 )); then
    color_digit=$MATCH
  else
    print "no match"
  fi

  print "^[[${bold_digit};${underline_digit};${color_digit}m"
}

local -r bold_green=$(bold-color-code 2)
local -r bold_yellow=$(bold-color-code 3)
local -r bold_underline_red=$(bold-underline-color-code 1)

cat -v << EOF
#env

# Output raw color control characters for styling.
# TODO: This seems unneeded on macOS, need to verify...
# LESS = -R

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
# LESS_TERMCAP_mb = $(tput blink)

# Turn on bold (extra bright) mode.
LESS_TERMCAP_md = $bold_green

# Turn off all attributes.
LESS_TERMCAP_me = $(tput sgr0)

# Turn on half-bright mode.
LESS_TERMCAP_mh = $(tput dim)

# Turn on reverse video mode.
LESS_TERMCAP_mr = $(tput rev) # Invert colors.

# Exit standout mode.
# LESS_TERMCAP_se = $(tput rmso; tput sgr0)

# Begin standout mode.
LESS_TERMCAP_so = $bold_yellow

# Exit underline mode.
# LESS_TERMCAP_ue = $(tput rmul; tput sgr0)

# Begin underline mode.
LESS_TERMCAP_us = $bold_underline_red
EOF
