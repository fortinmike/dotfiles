# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Installation

1. Clone this repository in `~/.dotfiles`:

        git clone [this_repos_url] ~/.dotfiles

2. Install chezmoi and apply the dotfiles:

        chezmoi init --apply ~/.dotfiles

3. Open a new shell

## Keeping Stuff Updated

- Full refresh: `dot-upgrade`
- Only apply dotfile changes: `dot-apply`
- Only update plugins: `dot-upgrade-plugins`

## Commands

- `dot-apply` applies the repo state to your home directory via chezmoi.
- `dot-upgrade-plugins` updates antidote and plugin repos, then rebuilds the bundle.
- `dot-upgrade` applies dotfiles and updates plugins in one step.

## Tooling

- chezmoi (dotfiles manager)
- antidote (ZSH plugin manager)
- starship (prompt)
- zoxide (directory jumper)
- eza (ls replacement)

## Directories

- **home** : Source state for chezmoi-managed dotfiles (maps into `$HOME`)
- **home/bin** : Small scripts that are made available on the `$PATH`
