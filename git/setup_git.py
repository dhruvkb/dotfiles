from pathlib import Path

def link_gitconfig():
    """
    Symlink the ``.gitconfig`` file in this directory to its namesake in
    ``$HOME``, where it will be picked up and used by Git.
    """

    gitconfig = Path.home() / '.gitconfig'
    local_gitconfig = Path(__file__).parent / '.gitconfig'

    gitconfig.unlink(missing_ok=True)
    gitconfig.symlink_to(local_gitconfig)

if __name__ == '__main__':
    link_gitconfig()
