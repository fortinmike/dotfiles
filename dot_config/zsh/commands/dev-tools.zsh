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

