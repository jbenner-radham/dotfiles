# Zsh Argument Parsing

A reference for argument parsing in zsh.

## Simple Argument Parsing

```zsh
function parse-args {
    local verbose=0
    local output=""

    while (( $# > 0 )); do
        case $1 in
            -v|--verbose)
                verbose=1
                shift
                ;;
            -o|--output)
                output=$2
                shift 2
                ;;
            -*)
                print -u2 "Unknown option: $1"
                return 1
                ;;
            *)
                # Positional argument
                break
                ;;
        esac
    done
}
```

Using zparseopts (Zsh Built-In)

```zsh
local -A opts
zparseopts -D -A opts -- v -verbose o: -output:

[[ -n ${opts[-v]} || -n ${opts[--verbose]} ]] && verbose=1
output=${opts[-o]:-${opts[--output]}}
```
