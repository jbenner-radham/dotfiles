---
name: zsh
description: Reference for zsh-specific syntax and idioms. Use when writing zsh scripts or configuring interactive zsh, especially when preferring zsh features over bash/POSIX equivalents.
---

# Zsh Quick Reference

Zsh-specific syntax and idioms. Assumes `setopt extended_glob`.

# Argument Parsing

For reference, see [argument-parsing](references/argument-parsing.md).

## Arrays

For reference, see [arrays.md](references/arrays.md).

## Associative Arrays

```zsh
typeset -A map=(key1 val1 key2 val2)
$map[key1]             # Access
${(k)map}              # Keys only
${(v)map}              # Values only
${(kv)map}             # Keys and values
```

## Parameter Expansion

```zsh
${var:l}               # Lowercase
${var:u}               # Uppercase
${var:t}               # Basename
${var:h}               # Dirname
${var:e}               # Extension
${var:r}               # Remove extension
${var/pat/rep}         # Replace first
${var//pat/rep}        # Replace all
${var:#pat}            # Remove if matches
${var:-default}        # Default if unset
${(f)var}              # Split on newlines
${(z)var}              # Split like shell words
```

## Globbing

```zsh
**/*.txt               # Recursive
**/file(.)             # Files only
**/dir(/)              # Dirs only
*(@)                   # Symlinks
*(om[1,5])             # 5 most recent
*(Lm+10)               # >10MB
*.txt~*.bak            # Exclude pattern
*.(txt|md)             # Multiple extensions
```

## Arithmetic

```zsh
(( x > 0 ))            # Comparison (preferred over [ ])
(( x++ ))              # Increment
(( x += 5 ))           # Add-assign
$(( x * y ))           # Arithmetic substitution
```

## Conditionals

```zsh
[[ -n $var ]]          # Non-empty string
[[ -z $var ]]          # Empty string
[[ $a == $b ]]         # String equal
[[ $a == *glob* ]]     # Glob match
[[ $a =~ regex ]]      # Regex match
```

## Loops

```zsh
for item in $arr; do ...; done           # Simple
for item in "${(@)arr}"; do ...; done    # Safe (preserves spaces)
for f in **/*.txt; do ...; done
for (( i=1; i<=10; i++ )); do ...; done
while read -r line; do ...; done < file
```

## Functions

```zsh
function my-func {
    local arg=$1
    local -a arr=("${@:2}")    # Rest args as array
    print -r -- "$arg"         # Safe print
}
```

## I/O

```zsh
print -r -- "$var"     # Raw print (no escape interpretation)
print -l $arr          # Print array, one per line
print -P "%F{red}hi"   # Prompt expansion (colors)
print -u 2 'Error!'    # Print to stderr
read -r var            # Read line
read -q "?Continue? "  # Yes/no prompt
```

## Zsh-specific Builtins

```zsh
autoload -Uz func      # Lazy-load function
zmodload zsh/datetime  # Load module
zparseopts -D -A opts -- v -verbose o:  # Parse CLI opts
zargs                  # xargs alternative
zmv '(*).txt' '$1.md'  # Batch rename
```

## Options (setopt/unsetopt)

```zsh
setopt EXTENDED_GLOB   # Advanced globs
setopt NULL_GLOB       # No error on empty glob
setopt ERR_EXIT        # Exit on error
setopt NO_UNSET        # Error on undefined var
setopt PIPEFAIL        # Fail on pipe error
setopt NO_CASE_GLOB    # Case-insensitive glob
setopt AUTO_CD         # cd by typing dir name
setopt CORRECT         # Command correction
```

## History

```zsh
!!                     # Previous command
!$                     # Last arg of previous
!^                     # First arg of previous
!:n                    # Nth arg of previous
^old^new               # Replace in previous
```

## Completion

```zsh
compinit               # Initialize completion
_files                 # Complete files
_directories           # Complete dirs
_command_names         # Complete commands
```
