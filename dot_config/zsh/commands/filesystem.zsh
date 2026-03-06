# Create a directory and go inside it
mkcd() {
  [ -n "$1" ] || { echo "mkcd: missing directory argument" >&2; return 1; }
  mkdir -p -- "$1" && cd -- "$1"
}

# Cd to the directory of a symlink's real target
cdl() {
  [ -n "$1" ] || { echo "cdl: missing symlink argument" >&2; return 1; }
  local link="$1"

  if [[ ! -e "$link" ]]; then
    link="$(command -v -- "$link")" || { echo "cdl: not found: $1" >&2; return 1; }
  fi

  [[ -L "$link" ]] || { echo "cdl: not a symlink: $link" >&2; return 1; }

  local target
  target="$(realpath "$link")" || return $?

  if [[ -d "$target" ]]; then
    cd -- "$target"
  else
    cd -- "$(dirname "$target")"
  fi
}
