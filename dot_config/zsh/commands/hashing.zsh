md5-file() {
  [ "$#" -eq 1 ] || { echo "md5-file: expected 1 file path" >&2; return 1; }
  [ -f "$1" ] || { echo "md5-file: not a file: $1" >&2; return 1; }

  if command -v md5 >/dev/null 2>&1; then
    command md5 -q "$1"
    return
  fi

  command md5sum "$1" | awk '{ print $1 }'
}

sha256-file() {
  [ "$#" -eq 1 ] || { echo "sha256-file: expected 1 file path" >&2; return 1; }
  [ -f "$1" ] || { echo "sha256-file: not a file: $1" >&2; return 1; }

  if command -v shasum >/dev/null 2>&1; then
    command shasum -a 256 "$1" | awk '{ print $1 }'
    return
  fi

  command sha256sum "$1" | awk '{ print $1 }'
}
