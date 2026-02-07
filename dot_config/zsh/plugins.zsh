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

# zsh-autosuggestions may wrap its own internal completion-capture widget.
# With completion strategy + custom Up/fzf history widgets, that re-entry can
# recurse through ZLE and leave stray high-CPU zsh processes.
# Excluding this internal widget prevents self-wrapping, while preserving the
# normal autosuggestion behavior for user-facing widgets.
typeset -ga ZSH_AUTOSUGGEST_IGNORE_WIDGETS
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(autosuggest-capture-completion)
