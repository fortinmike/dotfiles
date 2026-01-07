# Dotfiles Commands
function dot-update() {
  echo "Updating dotfiles from remote and applying using chezmoi..."
  chezmoi update
  echo "Restart your shell to load changes."
}

function dot-apply() {
  echo "Applying dotfiles using chezmoi..."
  chezmoi apply
  echo "Restart your shell to load changes."
}

function dot-update-plugins() {
  echo "Updating antidote plugins..."
  if [ -d "$HOME/.antidote/.git" ]; then
    # On linux, update the antidote clone itself
    git -C "$HOME/.antidote" pull --ff-only
  fi
  antidote update # Update the plugin repos
  antidote bundle <"$HOME/.config/zsh/antidote/plugins.txt" >| "$HOME/.config/zsh/antidote/.zsh_plugins.zsh" # Install or update our plugins
  echo "Restart your shell to load changes."
}

# Create a directory and go inside it
mkcd() { mkdir $1; cd $1; }

# Use eza for better defaults
alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'

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
alias cat='bat'
alias top='btop'
alias less='moor'

# Moor
alias mo='moor'

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
alias fk='ps -ef | fzf | awk '\''{print $2}'\'' | xargs kill -9'

# Kill apps via fuzzy finder
fka() {
  local app
  app="$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' \
    | tr ', ' '\n' | sed '/^$/d' | fzf)"
  [ -n "$app" ] && killall "$app"
}

# Open in Xcode
xcode() { open -a Xcode $1 &; }

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
