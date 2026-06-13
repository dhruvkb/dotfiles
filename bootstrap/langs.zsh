#!/usr/bin/env zsh

# This script sets up programming languages.

source "${0:A:h}/_common.zsh"

printf '┌─ Installing Python stable...\n'
# Resolve the latest stable Python major.minor from uv's download list.
python_version=$(uv python list --output-format json |
	jq -r '
      first(
        .[] | select(
          .implementation == "cpython"
          and .variant == "default"
          and (.version | test("^[0-9]+\\.[0-9]+\\.[0-9]+$"))
        )
      )
      | "\(.version_parts.major).\(.version_parts.minor)"
    ')
indent uv python install "$python_version"
# Now `python${python_version}` is in your `PATH`.
green '└─ done.\n'

printf '┌─ Installing Node.js LTS...\n'
# Install the latest LTS Node from fnm and use it in the current shell.
indent fnm use --install-if-missing lts/latest
# Persist the same version as the default for future shells.
indent fnm default lts/latest
# Now `node` and `npm` are in your `PATH`.
green '└─ done.\n'

printf '┌─ Enabling Corepack...\n'
# Corepack ships bundled with some Node majors and not others (dropped in v25+).
# Install it manually only when the active Node doesn't already provide it.
if ! command -v corepack >/dev/null 2>&1; then
	indent npm install -g corepack
fi
indent corepack enable pnpm
# Now `pnpm` is in your `PATH` (after a download confirmation from Corepack).
green '└─ done.\n'

printf '┌─ Installing Rust stable...\n'
# Install the latest stable Rust toolchain from rustup.
indent rustup default stable
# Now `rustc` and `cargo` are in your `PATH`.
green '└─ done.\n'
