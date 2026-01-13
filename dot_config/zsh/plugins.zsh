ANTIDOTE_BUNDLE="$HOME/.config/zsh/antidote/plugins.txt"
ANTIDOTE_CACHE="$HOME/.config/zsh/antidote/.zsh_plugins.zsh"

# Use Homebrew's antidote (macOS + Linuxbrew)
source "$($BREW_BIN --prefix antidote)/share/antidote/antidote.zsh"

autoload -Uz compinit
if [[ -z "$_comps" ]]; then
  # Cache zcompdump in cache dir and skip fpath security checks for faster startup
  ZSH_CACHE_DIR="$HOME/.cache/zsh"
  mkdir -p "$ZSH_CACHE_DIR"
  compinit -C -d "$ZSH_CACHE_DIR/zcompdump"
fi

# This fetches missing plugins and builds the bundle cache once during the first shell load
if [ ! -f "$ANTIDOTE_CACHE" ] || [ "$ANTIDOTE_BUNDLE" -nt "$ANTIDOTE_CACHE" ]; then
  antidote bundle <"$ANTIDOTE_BUNDLE" >| "$ANTIDOTE_CACHE"
fi

source "$ANTIDOTE_CACHE"
