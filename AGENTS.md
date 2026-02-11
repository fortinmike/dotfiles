# Agent Guidelines

This is a dotfiles repo with configurations for zsh and various command-line tools and aliases. The dotfiles are primarily meant for macOS but must also support Linux distros such as Raspberry Pi OS and other debian-based distros.

- Assume `brew` and `chezmoi` are available as it's a prerequisite for the user to install them when applying the dotfiles for the first time.
- Avoid unnecessary guards (we can assume that tools are installed and working, etc.)
- Avoid hacks and workarounds. These dotfiles must be stable and maintainable for the foreseeable future.
- Prefer failing fast to silently skipping logic and leaving a feature partially working or broken.
