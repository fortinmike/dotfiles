# Dotfiles Commands
function dot-reinstall () {
  echo "=> Applying dotfiles..."
  if command -v chezmoi >/dev/null 2>&1; then
    chezmoi apply
  else
    echo "chezmoi is not installed"
  fi
}

function dot-update () {
  echo "=> Updating antidote and plugins..."
  if [ -r "$HOME/.antidote/antidote.zsh" ]; then
    antidote update
    antidote bundle <"$HOME/.config/zsh/antidote/plugins.txt" >| "$HOME/.config/zsh/antidote/.zsh_plugins.zsh"
    source "$HOME/.config/zsh/antidote/.zsh_plugins.zsh"
    source ~/.zshrc
  else
    echo "Antidote not installed at $HOME/.antidote/antidote.zsh"
  fi
}

function dot-pull () {
  echo "=> Pulling latest dotfiles..."
  if command -v chezmoi >/dev/null 2>&1; then
    chezmoi update
  else
    echo "chezmoi is not installed"
  fi
}

# Create a directory and go inside it
mkcd() { mkdir $1; cd $1; }

# Use eza if installed
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --group-directories-first'
  alias la='eza -la --group-directories-first'
fi

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
