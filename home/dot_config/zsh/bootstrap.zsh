ZSH_CONFIG_DIR="${0:A:h}"

source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/commands.zsh"
source "$ZSH_CONFIG_DIR/key-bindings.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

if [ -e ~/.zshrc_local ]; then source ~/.zshrc_local; fi
