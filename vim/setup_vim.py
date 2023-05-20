#!/usr/bin/env python3
from pathlib import Path
from urllib import request


def provision_solarized():
    """
    Download Solarized colour scheme from GitHub and place it in the correct
    directory to be picked up by Vim.
    """

    colors = Path.home() / ".vim" / "colors"
    colors.mkdir(parents=True, exist_ok=True)

    request.urlretrieve(
        "https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim",
        colors.absolute() / "solarized.vim",
    )


def link_vimrc():
    """
    Symlink the ``.vimrc`` file in this directory to its namesake in ``$HOME``,
    where it will be picked up and used by Vim.
    """

    vimrc = Path.home() / ".vimrc"
    local_vimrc = Path(__file__).parent / ".vimrc"

    vimrc.unlink(missing_ok=True)
    vimrc.symlink_to(local_vimrc)


provision_solarized()
link_vimrc()
