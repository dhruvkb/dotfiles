# Z Shell

Configure Zsh by making this directory the `$ZSH_CUSTOM` directory. This will
cause all scripts defined here to be automatically sourced, in order, when the
terminal is initialised.

Run `just zsh` to do this. It is idempotent so it can be run multiple times, if
needed.

The script also

- disables the theme so that Starship can take over
- enables auto updates for Oh My Zsh
- configures my preferred set of plugins
