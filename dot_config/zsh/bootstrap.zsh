ZSH_CONFIG_DIR="${0:A:h}"

source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/commands.zsh"
source "$ZSH_CONFIG_DIR/hooks.zsh"
source "$ZSH_CONFIG_DIR/key-bindings.zsh"

if [ -e ~/.zshrc_local ]; then source ~/.zshrc_local; fi

source "$ZSH_CONFIG_DIR/bootstrap/starship.zsh"
source "$ZSH_CONFIG_DIR/bootstrap/zoxide.zsh"
