# Show public IP info as JSON
alias public-ip='curl https://ifconfig.co/json; printf "\n"'

_read_args_or_stdin_without_trailing_newline() {
  local input

  [ "$#" -gt 0 ] && {
    printf '%s' "${(j: :)@}"
    return
  }

  input="$(command cat; printf x)"
  input="${input%x}"
  input="${input%$'\n'}"
  printf '%s' "$input"
}

url-encode() {
  _read_args_or_stdin_without_trailing_newline "$@" | jq -sRr @uri
}

url-decode() {
  _read_args_or_stdin_without_trailing_newline "$@" | jq -sRr @urid
}

base64-encode() {
  [ "$#" -gt 0 ] && {
    printf '%s' "${(j: :)@}" | command base64 | tr -d '\n'
    printf '\n'
    return
  }

  command base64 | tr -d '\n'
  printf '\n'
}

base64-decode() {
  [ "$#" -gt 0 ] && {
    printf '%s' "${(j: :)@}" | command base64 -d
    return
  }

  command base64 -d
}

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
