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

# ----> OS X App Aliases

alias xcode="/Applications/Xcode.app/Contents/MacOS/Xcode"

# ----> Custom Commands

alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias configz="vim ~/.zshrc"
alias sourcez="source ~/.zshrc"

# ----> Antigen Config
# Note: The Antigen repo must be cloned manually in ~/.antigen

source antigen/antigen.zsh

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

