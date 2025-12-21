# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Installation

1. Clone this repository in `~/.dotfiles`:

        git clone [this_repos_url] ~/.dotfiles

2. Run the installer:

        ~/.dotfiles/install.sh

3. Open a new shell

## Important Files

- **home/dot_zshrc** : The entry point for ZSH shell bootstrapping (sourced in `~/.zshrc`)

## Directories

- **home** : Source state for chezmoi-managed dotfiles (maps into `$HOME`)
- **home/bin** : Small scripts that are made available on the `$PATH`
