# Dotfiles

This is my ZSH configuration and personal dotfiles. Please review everything before you attempt to use this. Some things might be macOS-specific, but I try to keep everything as platform-agnostic as possible. This is a public repository mostly for easy installs on additional machines, but feel free to take a look!

## Prerequisites

- ZSH configured as the default shell (it is by default on macOS)
- Git is installed (on macOS, install using `xcode-select --install`)
- Homebrew is installed (install from [brew.sh](https://brew.sh))

## Installation

0. Make sure zsh is the default shell: `echo $SHELL` (if not, set it as default using `chsh -s /usr/bin/zsh`)
1. Optionally, fork this project and use your own repo below (best so you can customize it and push your changes back)
2. Install and select a Nerd Font in Terminal (see "Font" below)
3. Install `chezmoi` using `brew` or using the install script on Linux
4. Run `chezmoi init --force --apply [this_repos_url]`
5. Open a new shell to view the results

## Main Moving Parts

- `chezmoi` (dotfiles manager, applies the files in this repo to your `$HOME`)
- `antidote` (ZSH plugin manager, reads plugins from `dot_config/zsh/antidote/plugins.txt`)
- `starship` (modern customizable prompt)

## Extras

- `zoxide` (`z` directory jumper command)
- `eza` (ls replacement)
- `rg` (ripgrep, fast search)
- `fzf` (fuzzy finder) + `fzf-tab` plugin (fzf-enhanced tab completion)
- `bat` (replaces `cat` with an alias)
- `btop` (replaces `top` with an alias)
- `moor` (replaces `less` with an alias)
- `tlrc` (modern tldr client with quick cheat sheets)
- `lazygit` (git TUI)
- Some other ZSH plugins and niceties (installed using antidote)
- A few aliases and tools to make life easier (`mkcd`, `reveal`, git and ripgrep shorthands, etc.)

## Keeping Stuff Updated

- Full refresh: `dot-update` (runs `chezmoi update` which pulls the latest changes from the remote and applies them)
- Only apply dotfile changes: `dot-apply` (runs `chezmoi apply` which applies the changes from the working copy into the home folder)
- Only update plugins: `dot-update-plugins`

## Modifying Your Setup

Use `chezmoi` commands such as `chezmoi edit` or open `~/local/share/chezmoi` (which contains the dotfiles working copy) in your editor of choice. Make any changes you want, commit them, then run `chezmoi apply` to apply those changes to your home folder. Make sure to push the changes back to the remote for backup and sharing with your other machines!

## Helper Commands

These commands can be used instead of the `chezmoi` and `antidote` commands in certain cases and simplify management.

- `dot-update` pulls the latest changes and applies them in one go via chezmoi (mostly a proxy for `chezmoi update`)
- `dot-apply` applies the working copy's state to your home directory via chezmoi (mostly a proxy for `chezmoi apply`)
- `dot-update-plugins` updates ZSH plugins using antidote (they don't update automatically when applying

## Font

To get nice glyphs in the pre-configured Starship prompt, install a Nerd Font. You can choose any font that has been patched with the Nerd Fonts patcher (many options [here](https://www.nerdfonts.com)), but I recommend using `SF Mono Nerd Font` which is derived from the SF Mono font by Apple (the Mac's default Terminal font).

Install it through homebrew: `brew tap epk/epk && brew install font-sf-mono-nerd-font` then select the regular weight in your Terminal profile.
