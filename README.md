# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use them. Some things might be OS X specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look.

# Installation

1. Clone this repository in ~/.zsh-config, WITH submodules:

        git clone --recursive [this_repos_url] ~/.zsh-config

2. Edit ~/.zshrc and replace its contents with:

        source .antigen-custom/zshrc.zsh

## Some Details

Rather than putting customizations in ~/.zshrc where they would be more difficult to backup, all customizations are added to ~/.zsh-config/zshrc.zsh, which is sourced in ~/.zshrc (in step 2 above). The ~/.zsh-config directory (e.g. the clone of this repo) is kept under version control for easy versioning and backup.
