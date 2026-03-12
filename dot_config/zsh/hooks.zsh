# Shell hooks (precmd/chpwd, etc.)

zmodload zsh/datetime

# Keep window/tab title in sync so it resets after SSH exits.
function _set_terminal_title() {
  # %n = user, %m = host (short)
  print -Pn "\e]0;%n@%m\a"
}
precmd_functions+=(_set_terminal_title)

function _macos_remote_login_protected_path() {
  [[ -n "$HOME" ]] || return 1

  local path="${1:A}" home="${HOME:A}" protected_dir
  local -a protected_dirs=(
    "$home/Desktop"
    "$home/Documents"
    "$home/Downloads"
    "$home/Library/Mobile Documents"
  )

  for protected_dir in $protected_dirs; do
    [[ "$path" == "$protected_dir" || "$path" == "$protected_dir"/* ]] && return 0
  done

  return 1
}

function _print_macos_remote_login_access_hint() {
  print -P "%F{yellow}[macOS]%f Access likely refused by macOS privacy controls. Check %BSystem Settings > General > Sharing > Remote Login > Allow full disk access for remote users%b."
}

# Auto-list small directories after cd (skip if > 80 entries)
function _autols_small_dir() {
  if [[ -o interactive ]]; then
    local count is_macos_remote_session=0
    [[ "$OSTYPE" == darwin* && -n "$SSH_TTY" ]] && is_macos_remote_session=1

    if ! command ls -A1 >/dev/null 2>&1; then
      if (( is_macos_remote_session )) && _macos_remote_login_protected_path "$PWD"; then
        _print_macos_remote_login_access_hint
      fi
      return
    fi

    count=$(command ls -A1 2>/dev/null | command wc -l | tr -d ' ')
    if [ -n "$count" ] && [ "$count" -le 80 ]; then
      command eza
    fi
  fi
}
chpwd_functions+=(_autols_small_dir)

# Dotfiles update notification (start async on first prompt, print on later prompt)
typeset -g _dotfiles_update_state=0
typeset -gi DOTFILES_UPDATE_CACHE_MAX_AGE=64800
typeset -g DOTFILES_UPDATE_CACHE_DIR="$HOME/.cache/zsh"
typeset -g DOTFILES_UPDATE_CACHE_FILE="$DOTFILES_UPDATE_CACHE_DIR/dotfiles-update.cache"
typeset -g DOTFILES_UPDATE_RESULT_FILE="$DOTFILES_UPDATE_CACHE_DIR/dotfiles-update-${UID}-$$.result"

_dotfiles_update_read_cache() {
  local checked_at behind
  [ -r "$DOTFILES_UPDATE_CACHE_FILE" ] || return 1
  read -r checked_at behind < "$DOTFILES_UPDATE_CACHE_FILE" || return 1
  [[ "$checked_at" == <-> && "$behind" == <-> ]] || return 1
  (( EPOCHSECONDS - checked_at < DOTFILES_UPDATE_CACHE_MAX_AGE )) || return 1
  print -r -- "$behind"
}

_dotfiles_update_precmd() {
  if [ "$_dotfiles_update_state" -eq 0 ]; then
    local cached_behind
    mkdir -p "$DOTFILES_UPDATE_CACHE_DIR"
    cached_behind="$(_dotfiles_update_read_cache)" || cached_behind=
    if [[ "$cached_behind" == <-> ]]; then
      print -r -- "$cached_behind" >| "$DOTFILES_UPDATE_RESULT_FILE"
      _dotfiles_update_state=1
      return
    fi

    _dotfiles_update_state=1
    (
      local behind=0
      # Fail fast so this async check does not leave long-lived ssh/git processes
      GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND='ssh -o BatchMode=yes -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=3 -o ServerAliveCountMax=1' \
        chezmoi git -- fetch --quiet --no-tags >/dev/null 2>&1 || true
      behind="$(chezmoi git -- rev-list --count HEAD..@{u} 2>/dev/null)" || behind=0
      [[ "$behind" == <-> ]] || behind=0
      print -r -- "$EPOCHSECONDS $behind" >| "$DOTFILES_UPDATE_CACHE_FILE"
      print -r -- "$behind" >| "$DOTFILES_UPDATE_RESULT_FILE"
    ) &!
    return
  fi

  [ "$_dotfiles_update_state" -eq 1 ] || return
  [ -r "$DOTFILES_UPDATE_RESULT_FILE" ] || return
  _dotfiles_update_state=2

  local behind
  read -r behind < "$DOTFILES_UPDATE_RESULT_FILE" || return
  command rm -f -- "$DOTFILES_UPDATE_RESULT_FILE"
  [[ "$behind" == <-> ]] || return
  [ "$behind" -gt 0 ] || return

  print -P "%F{yellow}[dotfiles]%f %B${behind}%b commit(s) behind upstream. Run %Bdot-update%b to update or %Bdot-status%b to view changes."
}
precmd_functions+=(_dotfiles_update_precmd)
