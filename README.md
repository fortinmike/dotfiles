# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use them. Some things might be OS X specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

# Installation

1. Clone this repository in ~/.dotfiles, **with submodules**:

        git clone --recursive [this_repos_url] ~/.dotfiles

2. Edit ~/.zshrc and replace its contents with:

        source ~/.dotfiles/main.zsh

## Some Details

Rather than putting customizations in ~/.zshrc where they would be more difficult to backup, all customizations are added to ~/.dotfiles/main.zsh, which is sourced in ~/.zshrc (step 2, above). The ~/.dotfiles repo is kept under version control for easy versioning and backup.
