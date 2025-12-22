# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Installation

1. Install a Nerd Font (which contains nice glyphs, see "Fonts" below)
1. Install `chezmoi` using `brew` or `apt-get`
2. Run `chezmoi init --apply [this_repos_url]`
4. Open a new shell

## Keeping Stuff Updated

- Full refresh: `dot-upgrade`
- Only apply dotfile changes: `dot-apply`
- Only update plugins: `dot-upgrade-plugins`

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
