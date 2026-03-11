# Kill process via fuzzy finder
fk() {
  local selection pid
  selection="$(ps -axo pid=,command= | fzf)"
  pid="${selection%% *}"
  [ -n "$pid" ] && kill -9 "$pid"
}

if [[ "$OSTYPE" == darwin* ]]; then
  # Kill apps via fuzzy finder
  fka() {
    local app
    app="$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' \
      | tr ', ' '\n' | sed '/^$/d' | fzf)"
    [ -n "$app" ] && killall "$app"
  }
fi
