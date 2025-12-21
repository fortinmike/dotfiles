ZSH_CONFIG_DIR="${0:A:h}"
DOTFILES_DIR=""

if [ -d "$HOME/.local/share/chezmoi" ]; then
  DOTFILES_DIR="$HOME/.local/share/chezmoi"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
fi

export DOTFILES_DIR

source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/commands.zsh"
source "$ZSH_CONFIG_DIR/key-bindings.zsh"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if [ -e ~/.zshrc_local ]; then source ~/.zshrc_local; fi
