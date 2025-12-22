# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Installation

This repo assumes that ZSH is configured as the active shell.

1. Install a Nerd Font (which contains nice glyphs, see "Fonts" below) and setup your terminal to use it
2. Install `chezmoi` using `brew` or `apt-get`
3. Run `chezmoi init --apply [this_repos_url]`
4. Open a new shell

## Keeping Stuff Updated

- Full refresh: `dot-update` (runs `chezmoi update` which pulls the latest changes from the remote and applies them)
- Only apply dotfile changes: `dot-apply` (runs `chezmoi apply` which applies the changes from the working copy into the home folder)
- Only update plugins: `dot-update-plugins`

## What These Do

- `dot-apply` applies the repo state to your home directory via chezmoi.
- `dot-upgrade-plugins` updates antidote and plugin repos, then rebuilds the bundle.
- `dot-upgrade` applies dotfiles and updates plugins in one step.

## Tooling

- chezmoi (dotfiles manager)
- antidote (ZSH plugin manager)
- starship (prompt)
- zoxide (directory jumper)
- eza (ls replacement)

Chezmoi applies the files in this repo to your `$HOME`. Antidote manages ZSH plugins
from `dot_config/zsh/antidote/plugins.txt`. Starship provides the prompt,
zoxide improves directory jumping, and eza replaces `ls`.

## Fonts

To get nice glyphs in the Starship prompt, install a Nerd Font. This font is derived from the Menlo font by Apple, patched with additional glyphs: MesloLG Nerd Font, downloadable [here](https://www.nerdfonts.com/font-downloads).

If you chose this font, install these files and select the regular font in the Terminal app's settings.

- MesloLGSNerdFontMono-Regular.ttf
- MesloLGSNerdFontMono-Bold.ttf
- MesloLGSNerdFontMono-Italic.ttf
- MesloLGSNerdFontMono-BoldItalic.ttf

## Directories

- **dot_config** : ZSH config and prompt config (maps into `$HOME/.config`)
- **dot_local/bin** : Small scripts that are made available on the `$PATH`
