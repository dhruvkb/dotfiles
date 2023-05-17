from pathlib import Path

def include_config():
    """
    Ensure that the local SSH config is included in the main SSH config file
    located in the ``$HOME`` directory.
    """

    local_config = Path(__file__).parent / "config"
    if f"Include {local_config}" not in config_lines:
        config_lines.append(f"Include {local_config}")


config = Path.home() / ".ssh/config"
config_lines = config.read_text().splitlines()

include_config()

config_lines.append('')
config.write_text("\n".join(config_lines))
