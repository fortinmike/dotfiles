# Dotfiles Commands

alias cdz="cd $DOTFILES_DIR"

function configz () {
  if [[ -z "$1" ]]; then
    vim "$DOTFILES_DIR/bootstrap.zsh"
  else
    file="$DOTFILES_DIR/shell/$1.zsh"
    if [ -f $file ]; then
      vim $file
    else
      echo "No config file exists at path $file"
    fi
  fi
}

function reinstallz () {
  echo "=> Reinstalling..."
  "$DOTFILES_DIR/install"
}

function updatez () {
  echo "=> Updating zgen and plugins..."
  zgen selfupdate
  zgen update
  git -C "$DOTFILES_DIR" add zgen
  git -C "$DOTFILES_DIR" commit -m "Fast-forward to latest zgen"
  source ~/.zshrc
}

function pullz () {
  echo "=> Pulling latest dotfiles..."
  git -C "$DOTFILES_DIR" pull
}

# Create a directory and go inside it
mkcd() { mkdir $1; cd $1; }


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
