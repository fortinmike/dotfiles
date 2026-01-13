# Agent Guidelines

- Assume `brew` is always available as it's a prerequisite for the user to install it before applying the dotfiles for the first time.
- Avoid unnecessary command presence checks (we can assume that the dotfiles install with homebrew in install scripts are present)
- Prefer failing fast to silently skipping logic and leaving a feature partially working or broken
