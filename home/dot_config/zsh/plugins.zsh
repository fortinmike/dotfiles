ANTIDOTE_DIR="$HOME/.antidote"
ANTIDOTE_BUNDLE="$HOME/.config/zsh/antidote/plugins.txt"
ANTIDOTE_CACHE="$HOME/.config/zsh/antidote/.zsh_plugins.zsh"

source "$ANTIDOTE_DIR/antidote.zsh"

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
