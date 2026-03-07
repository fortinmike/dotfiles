escape-json() {
  local input
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  jq -nr --arg s "$input" '$s | tojson | .[1:-1]'
}

unescape-json() {
  local input
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  printf '%s' "$input" | jq -Rr '"\"" + . + "\"" | fromjson'
}

escape-js() {
  local input escaped
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  escaped="$(jq -nr --arg s "$input" '$s | tojson | .[1:-1]')" || return $?
  printf '%s' "$escaped" | sed "s/'/\\\\'/g"
  printf '\n'
}

unescape-js() {
  local input
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  input="$(printf '%s' "$input" | sed "s/\\\\'/'/g")" || return $?
  printf '%s' "$input" | jq -Rr '"\"" + . + "\"" | fromjson'
}

escape-xml() {
  local input
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  printf '%s' "$input" | sed \
    -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e 's/"/\&quot;/g' \
    -e "s/'/\&apos;/g"
  printf '\n'
}

unescape-xml() {
  local input
  input="$(_read_args_or_stdin_without_trailing_newline "$@")" || return $?
  input="${input//&lt;/<}"
  input="${input//&gt;/>}"
  input="${input//&quot;/\"}"
  input="${input//&apos;/\'}"
  input="${input//&#39;/\'}"
  input="${input//&amp;/&}"
  printf '%s\n' "$input"
}
