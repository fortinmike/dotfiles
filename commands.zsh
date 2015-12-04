# ----> ZSH Config Commands

alias cdz="cd $THIS_DIR"
alias configz="vim $THIS_DIR/zshrc.zsh" # Edit this file rather than ~/.zshrc
alias sourcez="source ~/.zshrc" # ... but source the user's .zshrc file, which sources this file
alias updatez="echo 'Updating Antigen and bundles...'; git -C '$THIS_DIR' submodule foreach git pull origin master; git -C '$THIS_DIR' add antigen; git -C '$THIS_DIR' commit -m 'Updated antigen submodule'; antigen update; sourcez"

# ----> Useful Commands

alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"
alias cdg="cd-gitroot"
alias gc="git commit"
alias ga="git commit --amend"
mkcd() { mkdir $1; cd $1; }

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

