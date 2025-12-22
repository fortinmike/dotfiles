# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Prerequisites

- ZSH configured as the default shell (it is by default on macOS)
- Git is installed (on macOS, install using `xcode-select --install`)
- Homebrew is installed (install from [text](https://brew.sh))

## Installation

0. Optionally, fork this project and use your own repo below (best so you can customize it and push your changes back)
1. Install a Nerd Font (which contains nice glyphs, see "Fonts" below) and setup your terminal to use it
2. Install `chezmoi` using `brew` or `apt-get`
3. Run `chezmoi init --force --apply [this_repos_url]`
4. Open a new shell to view the results

## Keeping Stuff Updated

- Full refresh: `dot-update` (runs `chezmoi update` which pulls the latest changes from the remote and applies them)
- Only apply dotfile changes: `dot-apply` (runs `chezmoi apply` which applies the changes from the working copy into the home folder)
- Only update plugins: `dot-update-plugins`

## What These Do

- `dot-update` pulls the latest changes and applies them in one go via chezmoi
- `dot-apply` applies the working copy's state to your home directory via chezmoi
- `dot-update-plugins` updates ZSH plugins using antidote

## Tooling

- chezmoi (dotfiles manager, applies the files in this repo to your `$HOME`)
- antidote (ZSH plugin manager, reads plugins from `dot_config/zsh/antidote/plugins.txt`)
- starship (modern customizable prompt)
- zoxide (`z` directory jumper command)
- eza (ls replacement)

## Fonts

To get nice glyphs in the pre-configured Starship prompt, install a Nerd Font. The `MesloLG Nerd Font` is derived from the Menlo font by Apple (the Mac's default Terminal font), patched with additional glyphs. Download it [here](https://www.nerdfonts.com/font-downloads).

If you chose this font, install these files and select the regular font in the Terminal app's settings.

- MesloLGSNerdFontMono-Regular.ttf
- MesloLGSNerdFontMono-Bold.ttf
- MesloLGSNerdFontMono-Italic.ttf
- MesloLGSNerdFontMono-BoldItalic.ttf
