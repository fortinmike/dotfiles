# ----> ZSH Config Commands

alias cdz="cd $THIS_DIR"
alias configz="vim $THIS_DIR/zshrc.zsh" # Edit this file rather than ~/.zshrc
alias sourcez="source ~/.zshrc" # ... but source the user's .zshrc file, which sources this file
alias updatez="echo 'Updating Antigen and updating bundles...'; git submodule foreach git pull origin master; git add antigen; git commit -m 'Updated antigen submodule';  antigen update; sourcez"

# ----> Useful Commands

alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

