THIS_DIR=$(dirname $0)

# ----> Environment Variables

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X12/bin"
export PATH="$PATH:$HOME/Documents/Scripts/bash"
export PATH="$PATH:$HOME/Projects/Software/Ruby/git-multirepo/git-multirepo-migrations"

export EDITOR='vim'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# ----> Directories

export ALL="$HOME/Projects/Software/Xcode"
export PODS="$HOME/Projects/Software/Xcode/Pods"
export ST="$HOME/Projects/Software/Xcode/Sleepytime"
export BH="$HOME/Projects/Software/Xcode/Black Hole"
export DF="$HOME/Projects/Software/Xcode/Differences"
export PA="$HOME/Projects/Software/Xcode/Pauses"
export PP="$HOME/Projects/Software/Xcode/ProPicker"
export CL="$HOME/Projects/Software/Xcode/ClipCut" # Watch out! CC is used by CocoaPods for podspec validation!
export GB="$HOME/Projects/Software/Xcode/Gigabytes"
export VW="$HOME/Projects/Software/Xcode/VideoWall"
export RD="$HOME/Projects/Software/Xcode/Reado"
export AU="$HOME/Projects/Software/Xcode/Audition"
export XB="$HOME/Projects/Software/Xcode/XcodeBoost"
export MR="$HOME/Projects/Software/Ruby/git-multirepo"
export IR="$HOME/Sites/irradiated.net"
export MU="$HOME/Projects/Software/Simbioz/Muzeus.iOS"

# ----> Open With OS X Apps

xcode() { open -a Xcode $1 &; }
mou() { open -a Mou $1 &; }

# ----> Custom Commands

alias configz="vim $THIS_DIR/zshrc.zsh" # Edit this file rather than ~/.zshrc
alias sourcez="source ~/.zshrc" # ... but source the user's .zshrc file, which sources this file
alias updatez="echo 'Updating Antigen and updating bundles...'; git submodule foreach git pull origin master; git add antigen; git commit -m 'Updated antigen submodule';  antigen update; sourcez"
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias lsl="ls -la"

# ----> zsh-history-substring-search Key Bindings

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ----> Antigen Config
# Note: Make sure this repo was cloned including submodules!

source $THIS_DIR/antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme robbyrussell

antigen bundle git # git completions and more
antigen bundle sudo # Double-tap ESC to prefix current command with sudo
antigen bundle brew # Autocompletion for Homebrew, plus useful aliases
antigen bundle osx # Finder, QuickLook and more integrations in the shell
antigen bundle colorize # $ colorize [source file to display with syntax highlighting]
antigen bundle colored-man # $ Use man as always, now with color!
antigen bundle extract # $ x [file to extract]
antigen bundle autojump # $ Use the "j" alias to perform jumps (https://github.com/joelthelion/autojump)
antigen bundle gitignore # Generate default gitignores for various languages and IDE's: $ gi list; gi swift > .gitignore
antigen bundle pod # Autocompletion for CocoaPods
antigen bundle gem # Autocompletion for the "gem" command, plus some aliases

antigen bundle zsh-users/zsh-syntax-highlighting # Live command highlighting in the prompt
antigen bundle zsh-users/zsh-history-substring-search # Type partial command and press UP to find last command containing string

antigen apply

