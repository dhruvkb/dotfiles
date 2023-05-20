#!/usr/bin/env python3
from pathlib import Path


def disable_theme():
    """
    Disable Oh My Zsh themes, which are not required when using
    [Starship](https://starship.rs/) as the prompt.
    """

    for idx, line in enumerate(zshrc_lines):
        if line.startswith("ZSH_THEME"):
            zshrc_lines[idx] = 'ZSH_THEME=""'
            break


def enable_auto_updates():
    """
    Enable automatic installation of Oh My Zsh updates by uncommenting the line
    for that option.
    """

    for idx, line in enumerate(zshrc_lines):
        if "':omz:update' mode auto" in line:
            zshrc_lines[idx] = line.removeprefix("# ")
            break


def enable_plugins():
    """
    Enable plugins for Oh My Zsh that either I use a lot, or that reduce my
    custom configuration.
    """

    all_plugins = " ".join(
        [
            "brew",  # Runs `shellenv` to set up Homebrew.
            "git",
            "nvm",  # Configures env vars, loads nvm and sets up completions.
            "terraform",
        ]
    )

    for idx, line in enumerate(zshrc_lines):
        if line.startswith("plugins="):
            zshrc_lines[idx] = f"plugins=({all_plugins})"
            break


def use_custom_custom():
    """
    Use this directory as the custom directory for Oh My Zsh, which is where
    custom plugins, themes and auto-load scripts are stored.
    """

    dotfiles_zsh_dir = Path(__file__).parent.absolute()

    for idx, line in enumerate(zshrc_lines):
        if "ZSH_CUSTOM" in line:
            zshrc_lines[idx] = f"ZSH_CUSTOM={dotfiles_zsh_dir}"
            break


zshrc = Path.home() / ".zshrc"
zshrc_lines = zshrc.read_text().splitlines()

disable_theme()
enable_auto_updates()
enable_plugins()
use_custom_custom()

zshrc_lines.append("")
zshrc.write_text("\n".join(zshrc_lines))
