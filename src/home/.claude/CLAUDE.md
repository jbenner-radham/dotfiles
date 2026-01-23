Coding & Markup Style
---------------------

### Universal Guidelines

- If a project has an `.editorconfig` file read it and apply any relevant formatting rules to your context.
  - Wildcard sections apply to all files (e.g., `[*]`).
  - More specific section globs inherit from the wildcard sections configuration (e.g., `[*.zsh]` would inherit from `[*]` for a file named `example.zsh`).
  - If `max_line_length` is set, treat it as a strong preference and not a hard requirement. Specifically if long URLs make a line exceed that length it is acceptable.
- If you are unsure about a style issue ask clarifying questions.
- Prefer readability over "clever" code or compact markdown.
- Code should be concise as possible without sacrificing readability.
- Write self-documenting code and use comments sparingly. When we do write them, make sure they're for explaining the "why" or the context behind the function, method, etc.
- For files with shebangs always use `/usr/bin/env` (e.g., `#!/usr/bin/env node` for Node.js scripts and `#!/usr/bin/env zsh` for Zsh scripts).

### JavaScript & TypeScript

- Prefer a functional programming style.
  - Prefer immutable data unless using it would make code significantly more verbose or less performant.
  - Use the `map`, `reduce`, `forEach`, `filter`, etc. array methods over `for` loops.
- Use descriptive names and NEVER use one letter names (e.g., "error" instead of "e").
- Functions should take the form of `<verb><noun>` (e.g., `fetchPosts` instead of `posts`).
- Variables should be descriptive nouns (e.g., `postCount`).
- Utilize destructuring where possible.
- Prefer using the nullish coalescing operator (`??`) over the logical or operator (`||`);
- Use the optional chaining (`?.`) operator to traverse object properties or call a function or method.
- Use ternary expressions (`condition ? valueIfTrue : valueIfFalse`) over simple `if..else` statements.
- Prefer multiple small functions to a single large function.
- Public API members should be documented by [JSDoc](https://jsdoc.app/) for JavaScript and [TSDoc](https://tsdoc.org/) for TypeScript.
- Prefer `async/await` over `.then()` chains.
- Use `node:` protocol prefix for built-in modules in Node.js (e.g., `import path from 'node:path'`).

### Markdown

- Utilize the GitHub Flavored Markdown (GFM) dialect.
- Documents should be formatted to optimize readability when viewed as plain text.
- Headings should be immediately followed by a single empty line.
- Use GFM task lists for tasks and to-do lists.
- Use GFM tables when displaying data in a tabular format when it would be optimal.
- Use Setext headings for level one and two headings and ATX headings for any other level.
- Use a hyphen ("-") for bullet list markers.
- Bold text should be formatted like so: `**text**`.
- Italic text should be formatted like so: `_text_`.
- For code samples use fenced code blocks with an info string where applicable.
  - Use the long form over the short form for info strings (e.g., "typescript" instead of "ts").
  - Only use info strings supported by [linguist](https://github.com/github-linguist/linguist).
  - Since Zsh does not have a dedicated info string use either "shell" (e.g., to represent code in a script) or "sh-session" (e.g., to represent an interactive shell session), whichever is more applicable.
- HTML can be used sparingly when it would enhance the semantics of a document (e.g., use `<dl>` for a description list or `<abbr>` (with the `title` attribute like so: `<abbr title="JavaScript Object Notation">JSON</abbr>`) for abbreviations).
- Hyperlink to other sections when referencing them.
- Lists should be preceded by a single empty line between them and their preceding content.

### Shell (Zsh, Bash, POSIX Shell, etc.)

- Use long flags over short flags (e.g., `--verbose` not `-v`).
- Quote variables where applicable (e.g., `"${var}"` not `$var`).
- Where locally scoped variables are available name them in snake case convention (e.g., `foo_bar`).
- Exported variables should be in screaming snake case convention (e.g., `FOO_BAR`).
- Functions should be snake case (e.g., `foo_bar`) in most shells (e.g., Bash, POSIX Shell, etc.), but for shells like Zsh that support it use kebab case (e.g., `foo-bar`).

### Zsh

- A file is Zsh if it has the relevant shebang (e.g., `#!/usr/bin/env zsh`), a Zsh file extension (e.g., `script.zsh`), or is an explicit Zsh config file (e.g., `.zprofile`, `.zshenv`, `.zshrc`).
- Prefer using Zsh specific features to plain POSIX shell.
- Never write code outside of a function. If code doesn't need to be manually called and should be auto-executed then use an anonymous function as it provides scoping (e.g., `function { ... }`).
- All variables should be locally scoped.
- Where applicable make variables read only. Don't do it where it would be problematic. For instance if it would "swallow" the exit code and not catch errors (e.g., `local -r example="$(curl http://www.example.com/)"`).
- For variables that have array tied special variants (e.g., `$PATH` and `$FPATH`) prefer using those (e.g., `path+=('/path/to/source')` instead of `PATH="${PATH}:/path/to/source`).
- When adding items to the path or fpath ensure that they are not already present (e.g., `if (( ! $path[(Ie)/path/to/source] )); then path+=(/path/to/source); fi`).
