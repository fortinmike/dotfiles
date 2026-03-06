_dot_update_plugins() {
  echo "Updating antidote plugins..."
  # Refresh antidote function in case Homebrew updated it during chezmoi apply.
  source "$(${BREW_BIN:-brew} --prefix antidote 2>/dev/null)/share/antidote/antidote.zsh"
  # Update antidote plugin database
  antidote update || return $?
  # Install or update our plugins
  antidote bundle <"$HOME/.config/zsh/antidote/plugins.txt" >| "$HOME/.config/zsh/antidote/.zsh_plugins.zsh" || return $?
}

_dot_suggest_push_if_ahead() {
  local ahead
  ahead="$(chezmoi git -- rev-list --count @{u}..HEAD 2>/dev/null)" || return 0
  [[ "$ahead" == <-> ]] || return 0
  [ "$ahead" -gt 0 ] || return 0
  print -P "%F{yellow}Local dotfiles are ahead of upstream by %B${ahead}%b commit(s). Consider running %Bdot-push%b.%f"
}

function dot-update() {
  echo "Updating dotfiles from remote, applying, and updating plugins..."
  chezmoi update || return $?
  _dot_update_plugins || return $?
  printf '\033[0;32m%s\033[0m\n' "Restart your shell to load changes."
  _dot_suggest_push_if_ahead
}

function dot-push() {
  echo "Pushing dotfiles commits to upstream..."
  command git -C "$(chezmoi source-path)" push
}

function dot-apply() {
  echo "Applying dotfiles and updating plugins..."
  chezmoi apply || return $?
  _dot_update_plugins || return $?
  printf '\033[0;32m%s\033[0m\n' "Restart your shell to load changes."
  _dot_suggest_push_if_ahead
}

function dot-status() {
  local counts ahead behind line hash
  GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND='ssh -o BatchMode=yes' \
    chezmoi git -- fetch --quiet --no-tags >/dev/null 2>&1 || {
    print "Unable to fetch upstream status."
    return 1
  }

  counts="$(chezmoi git -- rev-list --left-right --count HEAD...@{u} 2>/dev/null)" || {
    print "Unable to determine upstream status."
    return 1
  }

  ahead="${counts%%[[:space:]]*}"
  behind="${counts##*[[:space:]]}"

  print
  print -P "%BLocal Only:%b"
  if [ "$ahead" -gt 0 ]; then
    while IFS= read -r line; do
      hash="${line%% *}"
      printf '\033[38;5;208m%s\033[0m %s\n' "$hash" "${line#* }"
    done < <(chezmoi git -- log --oneline --no-decorate @{u}..HEAD)
  else
    print "None"
  fi
  print

  print -P "%BRemote Only:%b"
  if [ "$behind" -gt 0 ]; then
    while IFS= read -r line; do
      hash="${line%% *}"
      printf '\033[38;5;141m%s\033[0m %s\n' "$hash" "${line#* }"
    done < <(chezmoi git -- log --oneline --no-decorate HEAD..@{u})
  else
    print "None"
  fi

  if [ "$ahead" -gt 0 ] && [ "$behind" -eq 0 ]; then
    print -P "\n%F{yellow}%B${ahead}%b local commits not pushed. Consider running %Bdot-push%b.%f"
  elif [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
    print -- ""
    print "Branch is diverged from upstream."
  elif [ "$behind" -gt 0 ]; then
    print -- ""
    print -P "%F{yellow}Update available. Consider running dot-update.%f"
  else
    print -- ""
    print -P "%F{green}Up to date with upstream.%f"
  fi
}

function dot-log() {
  chezmoi git -- log --graph --oneline --decorate --all "$@"
}
