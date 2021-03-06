# PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$DOTFILES_DIR/scripts"

# Configuration

export EDITOR='vim'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # Fixes python fork() issue on recent macOS
