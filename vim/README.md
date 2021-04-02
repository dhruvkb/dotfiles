# Steps

## Download Solarized color scheme

```sh
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim -o ~/.vim/colors/solarized.vim
```

## Placing RC file in `~`

Symlink the `.vimrc` file to the home directory `~`, and Vim will pick it up on
its own.

```sh
cd ~
ln -s ~/dotfiles/vim/.vimrc .vimrc
```
