# Dotfiles Commands
function dot-update () {
  echo "Updating from remote and applying dotfiles using chezmoi..."
  chezmoi update
  echo "Restart your shell to load changes."
}

function dot-apply () {
  echo "Applying dotfiles from working copy using chezmoi..."
  chezmoi apply
  echo "Restart your shell to load changes."
}

function dot-upgrade-plugins () {
  echo "Updating antidote and plugins..."
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

# Open in Xcode
xcode() { open -a Xcode $1 &; }

# Delete local Time Machine snapshots
delete_local_snapshots() {
  for d in $(tmutil listlocalsnapshotdates | grep "-");
  do sudo tmutil deletelocalsnapshots $d;
  done
}

# View man pages in Preview
# https://scriptingosx.com/2022/11/on-viewing-man-pages-ventura-update/
preman() {
  mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
}
