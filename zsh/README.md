# Steps

## Changes to `.zshrc`

Uncomment the line that sets `:omz:update` to `auto`.

```sh
zstyle ':omz:update' mode auto
```

## Customization

All `.zsh` files in the `$ZSH_CUSTOM` directory are automatically sourced when the terminal is initialized.

```sh
cd $ZSH_CUSTOM
rm example.sh
ln -s ~/dotfiles/zsh/*.zsh . # add all custom ZSH scripts to autoload
```
