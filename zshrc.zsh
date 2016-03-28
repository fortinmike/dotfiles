THIS_DIR=$(dirname $0)

# ----> zgen config
# Note: Make sure this repo was cloned w/ submodules!

source "$THIS_DIR/zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh themes/robbyrussell
  zgen oh-my-zsh plugins/git # git completions and more
  zgen oh-my-zsh plugins/sudo # Double-tap ESC to prefix current command with sudo
  zgen oh-my-zsh plugins/brew # Autocompletion for Homebrew, plus useful aliases
  zgen oh-my-zsh plugins/osx # Finder, QuickLook and more integrations in the shell
  zgen oh-my-zsh plugins/colorize # $ colorize [source file to display with syntax highlighting]
  zgen oh-my-zsh plugins/colored-man-pages # Use man as always, now with color!
  zgen oh-my-zsh plugins/extract # x [file to extract]
  zgen oh-my-zsh plugins/gitignore # Generate default gitignores for various languages and IDE's: $ gi list; gi swift > .gitignore
  zgen oh-my-zsh plugins/pod # Autocompletion for CocoaPods

  zgen load zsh-users/zsh-syntax-highlighting # Live command highlighting in the prompt
  zgen load zsh-users/zsh-history-substring-search # Type partial command and press UP to find last command containing string
  zgen load mollifier/cd-gitroot # Quickly cd to the current git root (alias in key-bindings.zsh)
  zgen load supercrabtree/k # ls alternative
  zgen load rupa/z # Quick navigation to recent folders

  zgen save
fi

source "$THIS_DIR/env.zsh"
source "$THIS_DIR/commands.zsh"
source "$THIS_DIR/key-bindings.zsh"

