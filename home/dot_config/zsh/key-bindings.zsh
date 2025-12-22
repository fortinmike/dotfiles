# Completion menu selection
bindkey -e # Use emacs keybindings in the line editor
zmodload zsh/complist
zstyle ':completion:*' menu select # Enable menu selection for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*' # Case-insensitive + substring matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Use LS_COLORS for completion listing
setopt auto_menu # Automatically show the completion menu on repeated tab
bindkey '^[[Z' reverse-menu-complete # Shift-Tab cycles backward

# Ensure common keybindings work in all terminals
bindkey '^A' beginning-of-line # Ctrl-A
bindkey '^K' kill-line # Ctrl-K
bindkey '^?' backward-delete-char # Delete/Backspace
bindkey '^H' backward-delete-char # Backspace on some terminals
bindkey '^[[3~' delete-char # Forward delete

# Key bindings for the "zsh-history-substring-search" plugin

# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
