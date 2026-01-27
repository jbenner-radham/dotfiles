Coding & Markup Style
---------------------

### Universal Guidelines

- Prefer readability over "clever" code or compact markdown.
- Code should be as concise as possible without sacrificing readability.
- Write self-documenting code and use comments sparingly. When we do write them, make sure they're for explaining the "why" or the context behind the function, method, etc.

### JavaScript & TypeScript

- Prefer a functional programming style.
  - Prefer immutable data unless using it would make code significantly more verbose or less performant.
  - Use functional array methods (e.g., `map`, `reduce`, `filter`, etc.) instead of `for` loops. Use `forEach` only when side effects are intentional.
- Use descriptive names and NEVER use one letter names (e.g., "error" instead of "e").
- Functions should take the form of `<verb><noun>` (e.g., `fetchPosts` instead of `posts`).
- Variables should be descriptive nouns (e.g., `postCount`).
- Utilize destructuring where possible.
- Prefer using the nullish coalescing operator (`??`) over the logical or operator (`||`).
- Use the optional chaining (`?.`) operator to traverse object properties or call a function or method.
- Use ternary expressions over simple `if..else` statements.
- Avoid using nested ternary expressions.
- Prefer multiple small functions to a single large function.
- Prefer `async/await` over `.then()` chains.
- Use `node:` protocol prefix when importing built-in modules in Node.js (e.g., `import path from 'node:path';`).
- Use numeric separators (`_`) to visually break up numbers which are greater than or equal to 1,000 (e.g., `1_000_000`)

### Shell (Zsh, Bash, POSIX Shell, etc.)

- Use long flags over short flags (e.g., `--verbose` not `-v`).
