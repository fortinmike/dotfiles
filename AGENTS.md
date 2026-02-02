# Agent Guidelines

- Assume `brew` and `chezmoi` are available as it's a prerequisite for the user to install them when applying the dotfiles for the first time.
- Avoid unnecessary guards (we can assume that tools are installed and working, etc.)
- Prefer failing fast to silently skipping logic and leaving a feature partially working or broken.
