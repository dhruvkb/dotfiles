# Steps

## Changes to `.zshrc`

0. Set `DISABLE_UPDATE_PROMPT` to `"true"`.
0. Uncomment the line for export of `LANG`.
    ```sh
    export LANG=en_US.UTF-8
    ```
0. Uncomment lines for the export of `EDITOR`.
    ```sh
    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='mvim'
    fi
    ```

## Customization

All `.zsh` files in the `$ZSH_CUSTOM` directory are automatically sourced when
the  terminal is initialized.

```sh
cd $ZSH_CUSTOM
ln -s ~/dotfiles/zsh/aliases.zsh aliases.zsh # set up aliases
ln -s ~/dotfiles/zsh/spaceship.zsh spaceship.zsh # configure Spaceship theme
```

### PATH changes (macOS only)

Packages, like Pipenv and HTTPie, are generally installed on the system-level
Python. But when installing them with `pip`, it is recommended to use the
`--user` flag.

The location where the packages are installed is not on the PATH by default and
must be added. Add the following lines towards the bottom of `.zshrc`.

```sh
# Packages like Pipenv and HTTPie are installed on system-wide Python 3
# but with the --user flag. They are, by default, not on the PATH.
export PATH="$PATH:/Users/dhruvkb/Library/Python/3.8/bin"
```
