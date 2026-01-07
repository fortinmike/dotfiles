ZSH_CONFIG_DIR="${0:A:h}"

source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/commands.zsh"
source "$ZSH_CONFIG_DIR/key-bindings.zsh"

# Load starship and zoxide using their explicit homebrew paths because
# homebrew might not yet have added its paths to PATH at this point.
eval "$("$BREW" --prefix starship)/bin/starship" init zsh)"
eval "$("$BREW" --prefix zoxide)/bin/zoxide" init zsh)"

if [ -e ~/.zshrc_local ]; then source ~/.zshrc_local; fi
