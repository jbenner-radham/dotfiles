Coding & Markup Style
---------------------

### Universal Guidelines

- If a project has an [EditorConfig](https://editorconfig.org/) file (`.editorconfig`), read it and apply any relevant formatting rules to your context.
  - Wildcard sections apply to all files (e.g., `[*]`).
  - More specific section globs inherit from the wildcard sections configuration (e.g., `[*.zsh]` would inherit from `[*]` for a file named `example.zsh`).
  - If `max_line_length` is set, treat it as a strong preference and not a hard requirement. Specifically if long URLs make a line exceed that length it is acceptable.
- If you are unsure about a style issue, ask clarifying questions.
- Prefer readability over "clever" code or compact markdown.
- Code should be as concise as possible without sacrificing readability.
- Write self-documenting code and use comments sparingly. When we do write them, make sure they're for explaining the "why" or the context behind the function, method, etc.
- For files with shebangs always use `/usr/bin/env` (e.g., `#!/usr/bin/env node` for Node.js scripts and `#!/usr/bin/env zsh` for Zsh scripts). Do not use a direct path to the binary (e.g., `#!/bin/zsh`, `#!/bin/sh`, etc.)

### JavaScript & TypeScript

- If a project has a [Prettier](https://prettier.io/) configuration (see [here](https://prettier.io/docs/configuration) for reference) abide by its formatting rules. Don't forget to account for the configuration defaults as well if a configuration parameter is not explicitly set in the project.
- Prefer a functional programming style.
  - Prefer immutable data unless using it would make code significantly more verbose or less performant.
  - Use functional array methods (e.g., `map`, `reduce`, `filter`, etc.) instead of `for` loops. Use `forEach` only when side effects are intentional.
- Use descriptive names and NEVER use one letter names (e.g., "error" instead of "e").
- Functions should take the form of `<verb><noun>` (e.g., `fetchPosts` instead of `posts`).
- Variables should be descriptive nouns (e.g., `postCount`).
- Utilize destructuring where possible (e.g., `const { prop } = object;`).
- Prefer using the nullish coalescing operator (`??`) over the logical or operator (`||`).
- Use the optional chaining (`?.`) operator to traverse object properties or call a function or method.
- Use ternary expressions over simple `if..else` statements.
- DO NOT use nested ternary expressions.
- Prefer multiple small functions to a single large function.
- Public API members should be documented by [JSDoc](https://jsdoc.app/) for JavaScript and [TSDoc](https://tsdoc.org/) for TypeScript.
- Prefer `async/await` over `.then()` chains.
- Use `node:` protocol prefix when importing built-in modules in Node.js (e.g., `import path from 'node:path';`).
- Use numeric separators (`_`) to visually break up numbers which are greater than or equal to 1,000 (e.g., `1_000_000`).

### Markdown

- Documents should be formatted to optimize readability when viewed as plain text.
- Headings should be immediately followed by a single empty line.
- Use Setext headings for level one and two headings and ATX headings for any other level.
- Use a hyphen ("-") for bullet list markers.
- Bold text should be formatted using asterisks (e.g., `**text**`).
- Italic text should be formatted using underscores (e.g., `_text_`).
- Lists should be preceded by a single empty line between them and their preceding content.

### Shell (Zsh, Bash, POSIX Shell, etc.)

- Use long flags over short flags (e.g., `--verbose` not `-v`).
- Quote variables where applicable (e.g., `"${var}"` not `$var`).
- Locally scoped variables are named in snake case convention (e.g., `foo_bar`).
- Exported variables should be in screaming snake case convention (e.g., `FOO_BAR`).
- Functions should be snake case (e.g., `foo_bar`) in most shells (e.g., Bash, POSIX Shell, etc.), but for shells like Zsh that support it use kebab case (e.g., `foo-bar`).

### Zsh

- A file is Zsh if it any of the following criteria are met:
  - Has the shebang: `#!/usr/bin/env zsh`.
  - Has a Zsh file extension (e.g., `script.zsh`).
  - Is a known Zsh config file (e.g., `.zprofile`, `.zshenv`, or `.zshrc`).
- Prefer using Zsh specific features to plain POSIX shell.
- Never write code outside of a function. If code doesn't need to be manually called and should be auto-executed then use an anonymous function as it provides scoping.
- All variables should be locally scoped.
- Where applicable make variables read only. Don't do it where it would be problematic. For instance if it would "swallow" the exit code and not catch errors.
