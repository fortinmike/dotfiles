THIS_DIR=$(dirname $0)

# ----> Antigen Config
# Note: Make sure this repo was cloned w/ submodules!

source "$THIS_DIR/antigen/antigen.zsh"

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
antigen bundle mollifier/cd-gitroot # Quickly cd to the current git root (alias in key-bindings.zsh)
antigen bundle supercrabtree/k # ls alternative

antigen apply

source "$THIS_DIR/env.zsh"
source "$THIS_DIR/commands.zsh"
source "$THIS_DIR/key-bindings.zsh"
source "$THIS_DIR/dotnet.zsh" # .NET tools and execution environment

