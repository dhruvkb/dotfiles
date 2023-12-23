#!/usr/bin/env bash

if [ ! -d "/opt/pipx" ]; then
  sudo mkdir /opt/pipx
  sudo chown -R "$(whoami)":admin /opt/pipx
fi

# Install pipx packages
pipx install poetry \
&& pipx install pipenv
