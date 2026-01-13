# Agent Guidelines

- Assume `brew` is always available as it's a prerequisite for the user to install it before applying the dotfiles for the first time.
- Avoid unnecessary guards (we can assume that tools are installed and working, etc.)
- Prefer failing fast to silently skipping logic and leaving a feature partially working or broken
