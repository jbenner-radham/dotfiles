dotfiles
========

My personal collection of dotfiles for macOS & Ubuntu.

Install
=======

Configure system settings (macOS):

```shell
./src/mac-os.zsh
```

Install prerequisites (currently just for Ubuntu):

```shell
./src/bootstrap.sh
```

Install Homebrew:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the Homebrew packages:

```shell
brew bundle install --file $PATH_TO_BREWFILE
```

Install the dotfiles:

> [!NOTE]
> You may want to review your current dotfiles before performing this step to
> ensure that you don't have any settings you'd like to save before they are
> potentially overwritten.

```shell
make install
```

Environment
===========

### Shell

[Z Shell](https://zsh.sourceforge.io/) is the primary shell.

- Plugins are managed via [Sheldon](https://sheldon.cli.rs/).
- The prompt utilized is [Starship](https://starship.rs/).
- The following config files are utilized (in order of load):
    1. `~/.zshenv`
    2. `~/.zprofile` (not loaded on Ubuntu)
    3. `~/.zshrc`
    4. `~/.config/zsh/*.zsh`

### Package Manager

Package management is (mostly) handled by [Homebrew](https://brew.sh/). On
Ubuntu some packages are managed by `apt` and `snap`.

Reference
=========

- https://andrewbaker.ninja/2023/10/26/macbook-osx-using-touch-id-fingerprints-to-enable-sudo/
- https://github.com/SixArm/unix-shell-script-tactics/
- https://github.com/client9/shlib/
- https://github.com/jlevy/the-art-of-command-line
- https://leebyron.com/til/mac-xdg/
- https://macos-defaults.com/
- https://google.github.io/styleguide/shellguide.html
- https://styles.goatbytes.io/lang/shell/
- https://wiki.zshell.dev/community/zsh_handbook
- http://redsymbol.net/articles/unofficial-bash-strict-mode/
