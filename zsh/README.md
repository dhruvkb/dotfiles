# Steps

## Changes to `.zshrc`

0. Uncomment the line that sets `:omz:update` to `auto`.
    ```sh
    zstyle ':omz:update' mode auto
    ```
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

All `.zsh` files in the `$ZSH_CUSTOM` directory are automatically sourced when the terminal is initialized.

```sh
cd $ZSH_CUSTOM
rm example.sh
ln -s ~/dotfiles/zsh/*.zsh . # add all custom ZSH scripts to autoload
```