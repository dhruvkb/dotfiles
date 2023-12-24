#!/usr/bin/env python3
from pathlib import Path


def link_plsyml():
    """
    Symlink the ``.pls.yml`` file in this directory to its namesake in
    ``$HOME``, where it will be picked up and used by ``pls``.
    """

    plsyml = Path.home() / ".pls.yml"
    local_plsyml = Path(__file__).parent / ".pls.yml"

    plsyml.unlink(missing_ok=True)
    plsyml.symlink_to(local_plsyml)


link_plsyml()
