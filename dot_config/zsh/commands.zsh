# Dotfiles Commands
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
  print -P "%F{yellow}[dotfiles]%f Local dotfiles are ahead of upstream by %B${ahead}%b commit(s). Consider running %Bdot-push%b."
}

function dot-update() {
  echo "Updating dotfiles from remote, applying, and updating plugins..."
  chezmoi update || return $?
  _dot_update_plugins || return $?
  _dot_suggest_push_if_ahead
  printf '\033[0;32m%s\033[0m\n' "Restart your shell to load changes."
}

function dot-push() {
  echo "Pushing dotfiles source commits to upstream..."
  chezmoi git -- push || return $?
}

function dot-apply() {
  echo "Applying dotfiles and updating plugins..."
  chezmoi apply || return $?
  _dot_update_plugins || return $?
  printf '\033[0;32m%s\033[0m\n' "Restart your shell to load changes."
}

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

# Use eza for better defaults
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'

# Navigation helpers (OMZ-like)
setopt auto_cd # Allow typing a dir name to cd into it
setopt auto_pushd # Push dirs onto stack when changing
setopt pushd_ignore_dups # Avoid duplicate entries in dir stack
setopt pushd_minus # Swap meanings of +/- for dir stack

alias ..='cd ..' # Up one directory
alias ...='cd ../..' # Up two directories
alias ....='cd ../../..' # Up three directories
alias .....='cd ../../../..' # Up four directories

# Grep color
alias grep='grep --color=auto' # Highlight matches

# Replace common commands with modern versions
alias bat='bat --style=plain' # Plain output: no header or line numbers
[[ -o interactive ]] && alias cat='bat' # Use bat only for interactive shells to avoid breaking scripts/pipelines
alias top='btop'

# Ripgrep helpers
alias rgf='rg --files' # List files rg would search
alias rgi='rg -i' # Case-insensitive search
alias rgl='rg -l' # List matching files only
alias rgw='rg -w' # Match whole words
alias rgh='rg --hidden --glob "!.git/*"' # Include hidden files, skip .git

# Git helpers
alias lg='lazygit'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias gl='git log --oneline --decorate --graph --all'
alias gp='git pull --ff-only'
alias gpr='git pull --rebase'
alias gpu='git push'

# Finder reveal
alias reveal='open -R'

# Kill process via fuzzy finder
fk() {
  local selection pid
  selection="$(ps -axo pid=,command= | fzf)"
  pid="${selection%% *}"
  [ -n "$pid" ] && kill -9 "$pid"
}

# Kill apps via fuzzy finder
fka() {
  local app
  app="$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' \
    | tr ', ' '\n' | sed '/^$/d' | fzf)"
  [ -n "$app" ] && killall "$app"
}

# Delete local Time Machine snapshots
delete-local-snapshots() {
  for d in $(tmutil listlocalsnapshotdates | grep "-");
  do sudo tmutil deletelocalsnapshots $d;
  done
}

# Flush DNS cache
flush-dns-cache() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "DNS cache flushed"
}
