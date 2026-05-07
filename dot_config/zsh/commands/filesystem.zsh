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

if [[ "$OSTYPE" == darwin* ]]; then
  # Delete local Time Machine snapshots
  delete-local-snapshots() {
    local line
    local snapshot_dates
    local i
    local d
    local -a snapshots
    local -a sorted_snapshots

    snapshot_dates="$(tmutil listlocalsnapshotdates)" || return $?

    while IFS= read -r line; do
      [[ "$line" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{6}$ ]] && snapshots+=("$line")
    done <<< "$snapshot_dates"

    if [ "${#snapshots[@]}" -eq 0 ]; then
      echo "No local snapshots found"
      return
    fi

    sorted_snapshots=("${(@o)snapshots}")

    if [ "${#snapshots[@]}" -eq 1 ]; then
      echo "✅ ${sorted_snapshots[1]} (keep)"
      echo "Nothing to delete (only one local snapshot found)"
      return
    fi

    # Keep the newest snapshot: removing all snapshots can force extra Time Machine work
    # Reference: https://eclecticlight.co/2026/02/02/which-snapshots-could-you-delete/
    local newest_snapshot="${sorted_snapshots[-1]}"
    for (( i = ${#sorted_snapshots[@]}; i >= 1; i-- )); do
      d="${sorted_snapshots[i]}"
      if [ "$d" = "$newest_snapshot" ]; then
        echo "✅ $d (keep)"
        continue
      fi
      echo "❌ $d (delete)"
    done

    for d in "${sorted_snapshots[@]}"; do
      [ "$d" = "$newest_snapshot" ] && continue
      sudo tmutil deletelocalsnapshots "$d" || return $?
    done
  }
fi
