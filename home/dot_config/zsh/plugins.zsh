ANTIDOTE_DIR="$HOME/.antidote"
ANTIDOTE_BUNDLE="$HOME/.config/zsh/antidote/plugins.txt"
ANTIDOTE_CACHE="$HOME/.config/zsh/antidote/.zsh_plugins.zsh"

if [ -r "$ANTIDOTE_DIR/antidote.zsh" ]; then
  source "$ANTIDOTE_DIR/antidote.zsh"

  if [ ! -f "$ANTIDOTE_CACHE" ] || [ "$ANTIDOTE_BUNDLE" -nt "$ANTIDOTE_CACHE" ]; then
    antidote bundle <"$ANTIDOTE_BUNDLE" >| "$ANTIDOTE_CACHE"
  fi

  source "$ANTIDOTE_CACHE"

  autoload -Uz compinit
  if [[ -z "$_comps" ]]; then
    compinit
  fi
else
  echo "antidote not found at $ANTIDOTE_DIR/antidote.zsh"
  echo "Install: git clone https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR"
fi
