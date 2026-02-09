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

# Dotfiles update notification (async fetch + one check per shell session)
typeset -g _dotfiles_update_checked=0
typeset -g _dotfiles_update_fetch_started=0
typeset -g _dotfiles_update_fetch_pid=0

_dotfiles_update_notice() {
  [ "$_dotfiles_update_checked" -eq 0 ] || return

  if [ "$_dotfiles_update_fetch_started" -eq 0 ]; then
    chezmoi git fetch --quiet --no-tags >/dev/null 2>&1 &!
    _dotfiles_update_fetch_pid="$!"
    _dotfiles_update_fetch_started=1
    return
  fi

  [ "$_dotfiles_update_fetch_pid" -gt 0 ] || return
  kill -0 "$_dotfiles_update_fetch_pid" 2>/dev/null && return

  local behind
  behind="$(chezmoi git rev-list --count HEAD..@{u} 2>/dev/null)" || {
    _dotfiles_update_checked=1
    return
  }
  _dotfiles_update_checked=1
  [[ "$behind" == <-> ]] || return
  [ "$behind" -gt 0 ] || return

  print -P "%F{yellow}[dotfiles]%f Update available: %B${behind}%b commit(s) behind upstream. Run %Bdot-update%b."
}
precmd_functions+=(_dotfiles_update_notice)
