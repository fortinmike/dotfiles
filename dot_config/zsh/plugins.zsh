ANTIDOTE_BUNDLE="$HOME/.config/zsh/antidote/plugins.txt"
ANTIDOTE_CACHE="$HOME/.config/zsh/antidote/.zsh_plugins.zsh"

# Use Homebrew's antidote (macOS + Linuxbrew)
source "$($BREW_BIN --prefix antidote)/share/antidote/antidote.zsh"

# This fetches missing plugins and builds the bundle cache once during the first shell load
if [ ! -f "$ANTIDOTE_CACHE" ] || [ "$ANTIDOTE_BUNDLE" -nt "$ANTIDOTE_CACHE" ]; then
  antidote bundle <"$ANTIDOTE_BUNDLE" >| "$ANTIDOTE_CACHE"
fi

source "$ANTIDOTE_CACHE"

autoload -Uz compinit
if [[ -z "$_comps" ]]; then
  # Cache zcompdump in XDG cache dir and skip fpath security checks for faster startup
  ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  mkdir -p "$ZSH_CACHE_DIR"
  compinit -C -d "$ZSH_CACHE_DIR/zcompdump"
fi
