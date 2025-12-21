# Dotfiles Commands
function _dot-reload () {
  source ~/.zshrc
}

function _dot-update-plugins () {
  git -C "$HOME/.antidote" pull --ff-only # Update antidote itself
  antidote update # Update the plugin repos
  antidote bundle <"$HOME/.config/zsh/antidote/plugins.txt" >| "$HOME/.config/zsh/antidote/.zsh_plugins.zsh" # Install or update our plugins
  source "$HOME/.config/zsh/antidote/.zsh_plugins.zsh" # Source the plugins so they apply instantly
}

function dot-apply () {
  echo "=> Applying dotfiles using chezmoi..."
  chezmoi apply
  _dot-reload
}

function dot-upgrade () {
  echo "=> Applying dotfiles using chezmoi and updating antidote and plugins..."
  chezmoi apply
  _dot-update-plugins
  _dot-reload
}

function dot-upgrade-plugins () {
  echo "=> Updating antidote and plugins..."
  _dot-update-plugins
  _dot-reload
}

# Create a directory and go inside it
mkcd() { mkdir $1; cd $1; }

# Use eza for better defaults
alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'

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
