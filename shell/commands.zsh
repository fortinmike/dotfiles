# ----> Dotfiles Commands

alias cdz="cd $THIS_DIR"
alias reloadz="zgen reset; source ~/.zshrc"

function configz () {
  if [[ -z "$1" ]]; then
    vim "$THIS_DIR/bootstrap.zsh"
  else
    file="$THIS_DIR/shell/$1.zsh"
    if [ -f $file ]; then
      vim $file
    else
      echo "No config file exists at path $file"
    fi
  fi
}

function updatez () {
  echo "--> Updating zgen and plugins..."
  zgen selfupdate
  zgen update
  git -C "$THIS_DIR" add zgen
  git -C "$THIS_DIR/.." commit -m "Fast-forward to latest zgen"
  source ~/.zshrc
}

function pullz () {
  echo "--> Pulling latest dotfiles"
  git -C "$THIS_DIR" pull
}

# ----> Useful Commands

alias weather="curl -4 wttr.in/montreal"
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"
alias cdg="cd-gitroot"
mkcd() { mkdir $1; cd $1; }

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

