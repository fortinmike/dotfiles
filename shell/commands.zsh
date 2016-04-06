# ----> Dotfiles Commands

alias cdz="cd $THIS_DIR"
alias configz="vim $THIS_DIR/bootstrap.zsh" # Edit this repo rather than ~/.zshrc
alias reloadz="zgen reset; source ~/.zshrc"
alias updatez="echo '--> Updating zgen and plugins...'; zgen selfupdate; zgen update; git -C '$THIS_DIR' add zgen; git -C '$THIS_DIR/..' commit -m 'Fast-forward to latest zgen'; source ~/.zshrc"
alias pullz="git -C '$THIS_DIR' pull; updatez"

# ----> Useful Commands

alias weather="curl -4 wttr.in/montreal"
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"
alias cdg="cd-gitroot"
mkcd() { mkdir $1; cd $1; }

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

