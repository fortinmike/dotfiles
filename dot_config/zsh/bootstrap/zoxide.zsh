# Use zoxide's explicit homebrew path because homebrew might not yet
# have added its paths to PATH at this point
ZOXIDE_BIN="$("$BREW_BIN" --prefix zoxide)/bin/zoxide"
eval "$("$ZOXIDE_BIN" init zsh)"
