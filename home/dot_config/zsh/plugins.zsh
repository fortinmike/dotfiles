ANTIDOTE_BUNDLE="$HOME/.config/zsh/antidote/plugins.txt"
ANTIDOTE_CACHE="$HOME/.config/zsh/antidote/.zsh_plugins.zsh"

# Prefer Homebrew's antidote on macOS; fall back to the git clone on Linux.
if [ -x /opt/homebrew/bin/brew ]; then
  ANTIDOTE_ZSH="$(/opt/homebrew/bin/brew --prefix antidote)/share/antidote/antidote.zsh"
elif [ -x /usr/local/bin/brew ]; then
  ANTIDOTE_ZSH="$(/usr/local/bin/brew --prefix antidote)/share/antidote/antidote.zsh"
else
  ANTIDOTE_ZSH="$HOME/.antidote/antidote.zsh"
fi

source "$ANTIDOTE_ZSH"

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
