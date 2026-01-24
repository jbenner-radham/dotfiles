# Zsh Arrays

Comprehensive reference for zsh arrays. Zsh arrays are **1-indexed** (bash uses 0-indexed).

## Declaration

```zsh
arr=()                 # Declare empty array
arr=(a b c)            # Declare with values
arr=(a b c)            # Assign (creates if unset)
arr=()                 # Empty array
```

## Indexing

```zsh
$arr[1]                # First element
$arr[-1]               # Last element
$arr[2,4]              # Elements 2 through 4
$arr[2,-1]             # Elements 2 through end
$arr[(i)val]           # Index of first match
$arr[(I)val]           # Index of last match
```

## Modification

```zsh
arr+=(x y)             # Append elements
arr=(new $arr)         # Prepend element
arr[3]=replaced        # Replace at index
arr[2]=()              # Remove element at index
arr[(i)val]=()         # Remove first matching element
arr=("${(@)arr:#pat}") # Remove elements matching pattern
arr[1,0]=(x y)         # Insert at beginning
arr[3,2]=(x)           # Insert after index 2
```

## Length and Membership

```zsh
${#arr}                # Array length
${#arr[1]}             # Length of first element
(( ${arr[(I)val]} ))   # True if val exists in arr
(( ${#arr} == 0 ))     # True if array is empty
```

## Expansion

```zsh
$arr                   # All elements (simple case)
"${(@)arr}"            # All elements (preserves spaces/empty)
${(j:,:)arr}           # Join with comma
${(j:\n:)arr}          # Join with newline
${(s:,:)str}           # Split string into array
${(u)arr}              # Unique elements only
${(o)arr}              # Sort ascending (lexical)
${(O)arr}              # Sort descending
${(on)arr}             # Sort ascending (numeric)
${(oi)arr}             # Sort ascending (case-insensitive)
```

## Filtering

```zsh
${arr:#pat}            # Elements NOT matching pattern
${(M)arr:#pat}         # Elements matching pattern
${arr:|other}          # Elements in arr but not in other
${arr:*other}          # Elements in both arr and other
```

## Transformation

```zsh
${(L)arr}              # Lowercase all elements
${(U)arr}              # Uppercase all elements
${(C)arr}              # Capitalize all elements
${arr/pat/rep}         # Replace in each element (first)
${arr//pat/rep}        # Replace in each element (all)
```

## Iteration

```zsh
# Simple (elements without spaces)
for item in $arr; do
    print "$item"
done

# Safe (preserves spaces and empty elements)
for item in "${(@)arr}"; do
    print "$item"
done

# With index
for (( i=1; i<=${#arr}; i++ )); do
    print "[$i]: $arr[i]"
done
```

## Copying and Combining

```zsh
new=($arr)             # Copy array
combined=($a $b)       # Concatenate arrays
```

## From Command Output

```zsh
arr=("${(@f)$(command)}")  # Split output by newlines
arr=(${(f)"$(command)"})   # Same, alternative syntax
arr=($(command))           # Split on whitespace (usually wrong)
```

## Associative Arrays

```zsh
typeset -A map              # Declare
map=(key1 val1 key2 val2)   # Initialize
map[key]=value              # Set
$map[key]                   # Get
${(k)map}                   # Keys only
${(v)map}                   # Values only
${(kv)map}                  # Keys and values interleaved
unset "map[key]"            # Remove key
(( ${+map[key]} ))          # True if key exists
${#map}                     # Number of keys
```

## Common Patterns

```zsh
# Check if value in array
if (( ${arr[(Ie)needle]} )); then
    print "found"
fi

# Remove duplicates preserving order
arr=(${(u)arr})

# Reverse array
arr=(${(Oa)arr})

# Read file into array (by lines)
arr=("${(@f)$(<file)}")

# Join array for display
print "${(j:, :)arr}"
```
