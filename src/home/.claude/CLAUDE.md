Coding & Markup Style
---------------------

### Universal Guidelines

- If a project has an `.editorconfig` file, read it and apply any relevant formatting rules to your context.
  - Wildcard sections apply to all files (e.g., `[*]`).
  - More specific section globs inherit from the wildcard sections configuration (e.g., `[*.zsh]` would inherit from `[*]` for a file named `example.zsh`).
  - If `max_line_length` is set, treat it as a strong preference and not a hard requirement. Specifically if long URLs make a line exceed that length it is acceptable.
- If you are unsure about a style issue, ask clarifying questions.
- Prefer readability over "clever" code or compact markdown.
- Code should be as concise as possible without sacrificing readability.
- Write self-documenting code and use comments sparingly. When we do write them, make sure they're for explaining the "why" or the context behind the function, method, etc.
- For files with shebangs always use `/usr/bin/env` (e.g., `#!/usr/bin/env node` for Node.js scripts and `#!/usr/bin/env zsh` for Zsh scripts). Do not use a direct path to the binary (e.g., `#!/bin/zsh`, `#!/bin/sh`, etc.)

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

  ```javascript
  // Do this:
  function foo(condition) {
    return condition ? 'valueIfTrue' : 'valueIfFalse'
  }

  // Not this:
  function foo(condition) {
    if (condition) {
      return 'valueIfTrue';
    } else {
      return 'valueIfFalse';
    }
  }
  ```
- If a ternary expression is too long break it down into multiple lines using the format in the following example.

  ```typescript
  // Do this:
  function foo(condition) {
    return condition
      ? 'valueIfTrue'
      : 'valueIfFalse';
  }

  // Not this:
  function foo(condition) {
    return condition
      ? 'valueIfTrue' : 'valueIfFalse';
  }
  ```
- Avoid using nested ternary expressions.
- Prefer multiple small functions to a single large function.
- Public API members should be documented by [JSDoc](https://jsdoc.app/) for JavaScript and [TSDoc](https://tsdoc.org/) for TypeScript.
- Prefer `async/await` over `.then()` chains.
- Use `node:` protocol prefix for built-in modules in Node.js.

  ```typescript
  // Do this:
  import path from 'node:path';

  // Not this:
  import path from 'path';
  ```

### Markdown

- Utilize the [GitHub Flavored Markdown (GFM)](https://github.github.com/gfm/) dialect.
- Documents should be formatted to optimize readability when viewed as plain text.
- Headings should be immediately followed by a single empty line.
- Use GFM task lists for tasks and to-do lists.

  ```markdown
  <!-- Do this: -->
  - [ ] Create example component.

  <!-- Not this: -->
  - Create example component.
  ```
- Use GFM tables when displaying data in a tabular format when it would be optimal.

  ````markdown
  <!-- Do this: -->
  | Foo | Hello |
  |-----|-------|
  | Bar | World |

  <!-- Not this: -->
  - **Foo**: Bar
  - **Hello**: World
  ````
- Use Setext headings for level one and two headings and ATX headings for any other level.
- Use a hyphen ("-") for bullet list markers.

  ```markdown
  <!-- Do this: -->
  - Item A
  - Item B

  <!-- Not this: -->
  * Item A
  * Item B
  ```
- Bold text should be formatted using asterisks.

  ```markdown
  <!-- Do this: -->
  **text**

  <!-- Not this: -->
  __text__
  ```
- Italic text should be formatted using underscores.

  ```markdown
  <!-- Do this: -->
  _text_

  <!-- Not this: -->
  *text*
  ```
- For code samples use fenced code blocks with an info string where applicable.
  - Use the long form over the short form for info strings.

    ````markdown
    <!-- Do this: -->
    ```typescript
    console.log('Hello, world!');
    ```

    <!-- Not this: -->
    ```ts
    console.log('Hello, world!');
    ```
    ````
  - Only use info strings supported by [linguist](https://github.com/github-linguist/linguist).
  - Since Zsh does not have a dedicated info string use either "shell" (e.g., to represent code in a script) or "sh-session" (e.g., to represent an interactive shell session), whichever is more applicable.
- HTML can be used sparingly when it would enhance the semantics of a document (e.g., use `<dl>` for a description list or `<abbr>` (with the `title` attribute like so: `<abbr title="JavaScript Object Notation">JSON</abbr>`) for abbreviations).
- Hyperlink to other sections when referencing them.
- Lists should be preceded by a single empty line between them and their preceding content.
- If you have more than one hyperlink to the same URL make it a link reference definition.

  ```markdown
  <!-- Do this: -->
  Go to [example]. If you're feeling redundant go to [example] again.

  [EXAMPLE]: http://www.example.com/

  <!-- Not this: -->
  Go to [example](http://www.example.com/). If you're feeling redundant go to [example](http://www.example.com/) again.
  ```
- If you have any link reference definitions in your document they should all be grouped together at the bottom of the document and have uppercase link labels.
- When placing shortcut reference links keep in mind that their link labels do not have to have the same casing as the corresponding link reference definition. So conform to the proper casing for the context in which the shortcut reference link was inserted.

  ```markdown
  <!-- Do this: -->
  Here is the [example].

  [EXAMPLE]: http://www.example.com/

  <!-- Or this: -->
  We capitalize this shortcut reference link to [Node] since it's a formal name.

  [NODE]: https://nodejs.org/

  <!-- Not this: -->
  Here is the [EXAMPLE].

  [EXAMPLE]: http://www.example.com/
  ```
- If a file is named `CHANGELOG.md` and has the following at the top of the document (allowing for version variations of the two URLs present) make sure any changes to it adhere to the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) spec.

  ```markdown
  Changelog
  =========

  All notable changes to this project will be documented in this file.

  The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
  and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
  ```

### Shell (Zsh, Bash, POSIX Shell, etc.)

- Use long flags over short flags (e.g., `--verbose` not `-v`).
- Quote variables where applicable (e.g., `"${var}"` not `$var`).
- Where locally scoped variables are available name them in snake case convention (e.g., `foo_bar`).
- Exported variables should be in screaming snake case convention (e.g., `FOO_BAR`).
- Functions should be snake case (e.g., `foo_bar`) in most shells (e.g., Bash, POSIX Shell, etc.), but for shells like Zsh that support it use kebab case (e.g., `foo-bar`).

### Zsh

- A file is Zsh if it any of the following criteria are met:
  - Has the shebang: `#!/usr/bin/env zsh`.
  - Has a Zsh file extension (e.g., `script.zsh`).
  - Is a known Zsh config file (e.g., `.zprofile`, `.zshenv`, or `.zshrc`).
- Prefer using Zsh specific features to plain POSIX shell.
- Never write code outside of a function. If code doesn't need to be manually called and should be auto-executed then use an anonymous function as it provides scoping.

  ```shell
  # Do this:
  function {
    print 'Hello world!'
  }

  # Not this:
  print 'Hello world!'
  ```
- All variables should be locally scoped.
- Where applicable make variables read only. Don't do it where it would be problematic. For instance if it would "swallow" the exit code and not catch errors.

  ```shell
  # Do this:
  local good_example

  good_example="$(curl http://www.example.com/)"


  # Not this:
  local -r bad_example="$(curl http://www.example.com/)"
  ```
- For variables that have array tied special variants (e.g., `$PATH` and `$FPATH`) prefer using those.

  ```shell
  # Do this:
  path+=('/path/to/source')

  # Not this:
  PATH="${PATH}:/path/to/source"
  ```
- When adding items to the `path` or `fpath` ensure that they are not already present.

  ```shell
  # Do this:
  if (( ! $path[(Ie)/path/to/source] )); then
    path+=(/path/to/source)
  fi

  # Not this:
  path+=(/path/to/source)
  ```
