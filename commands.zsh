# ----> ZSH Config Commands

alias cdz="cd $THIS_DIR"
alias configz="vim $THIS_DIR/zshrc.zsh" # Edit this repo rather than ~/.zshrc
alias resetz="zgen reset; source ~/.zshrc" # ... but source the user's .zshrc file, which sources this file
alias updatez="echo '--> Updating zgen and installed plugins...'; zgen selfupdate; zgen update; git -C '$THIS_DIR' add zgen; git -C '$THIS_DIR' commit -m '--> Pull latest zgen from origin'; source ~/.zshrc"

# ----> Useful Commands

alias weather="curl -4 wttr.in/montreal"
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"
alias cdg="cd-gitroot"
mkcd() { mkdir $1; cd $1; }

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

