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
