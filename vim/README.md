# Vim

Configure Vim by linking the included `.vimrc` file to `$HOME`.

Run `just vim` to do this. It is idempotent so it can be run multiple times, if
needed.

The script also downloads the Solarized color scheme, which is referenced in
`.vimrc`, to `$HOME/.vim/colors/`.
