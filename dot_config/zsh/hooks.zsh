# Shell hooks (precmd/chpwd, etc.)

# Keep window/tab title in sync so it resets after SSH exits.
function _set_terminal_title() {
  # %n = user, %m = host (short)
  print -Pn "\e]0;%n@%m\a"
}
precmd_functions+=(_set_terminal_title)

# Auto-list small directories after cd (skip if > 40 entries)
function _autols_small_dir() {
  if [[ -o interactive ]]; then
    local count
    count=$(command ls -A1 2>/dev/null | command wc -l | tr -d ' ')
    if [ -n "$count" ] && [ "$count" -le 80 ]; then
      command eza
    fi
  fi
}
chpwd_functions+=(_autols_small_dir)
