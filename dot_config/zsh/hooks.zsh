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

# Dotfiles update notification (start async on first prompt, print on later prompt)
typeset -g _dotfiles_update_state=0
typeset -g DOTFILES_UPDATE_RESULT_FILE="${${TMPDIR:-/tmp}%/}/dotfiles-update-${UID}-$$.result"

_dotfiles_update_precmd() {
  if [ "$_dotfiles_update_state" -eq 0 ]; then
    _dotfiles_update_state=1
    (
      local behind=0
      # Fail fast so this async check does not leave long-lived ssh/git processes
      GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND='ssh -o BatchMode=yes -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=3 -o ServerAliveCountMax=1' \
        chezmoi git -- fetch --quiet --no-tags >/dev/null 2>&1 || true
      behind="$(chezmoi git -- rev-list --count HEAD..@{u} 2>/dev/null)" || behind=0
      print -r -- "$behind" >| "$DOTFILES_UPDATE_RESULT_FILE"
    ) &!
    return
  fi

  [ "$_dotfiles_update_state" -eq 1 ] || return
  [ -r "$DOTFILES_UPDATE_RESULT_FILE" ] || return
  _dotfiles_update_state=2

  local behind
  read -r behind < "$DOTFILES_UPDATE_RESULT_FILE" || return
  [[ "$behind" == <-> ]] || return
  [ "$behind" -gt 0 ] || return

  print -P "%F{yellow}[dotfiles]%f %B${behind}%b commit(s) behind upstream. Run %Bdot-update%b to update or %Bdot-status%b to view changes."
}
precmd_functions+=(_dotfiles_update_precmd)
