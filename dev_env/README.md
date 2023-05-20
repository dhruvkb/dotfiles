# Development environment

## Manual

- Brew [[link]](https://brew.sh/)
- Oh My Zsh [[link]](https://ohmyz.sh/#install)
- nvm [[link]](https://github.com/nvm-sh/nvm#installing-and-updating)
- `rustup` [[link]](https://www.rust-lang.org/tools/install)

## Scripted

Install all Brew formulae, Brew casks and pipx packages.

Run `just dev` to do this. This recipe is partially idempotent, it will install
missing packages and update the installed ones. Between Brew formulae and casks,
and pipx, all major development software is covered.

> **Note** The pipx script may need `sudo` permissions if the `/opt/pipx/`
> directory does not exist and needs to be created.

## App Store

The following apps are installed from the macOS App Store:

- One Thing
- Slack
- WhatsApp Desktop
