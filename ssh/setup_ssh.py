#!/usr/bin/env python3
from pathlib import Path


def include_config():
    """
    Ensure that the local SSH config is included in the main SSH config file
    located in the ``$HOME`` directory.
    """

    local_config = Path(__file__).parent / "config"
    if (cfg_line := f"Include {local_config}") not in config_lines:
        config_lines.append(cfg_line)


config = Path.home() / ".ssh/config"
config_lines = config.read_text().splitlines()

include_config()

config_lines.append("")
config.write_text("\n".join(config_lines))
