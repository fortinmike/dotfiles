# Completion menu selection
bindkey -e # Use emacs keybindings in the line editor
zmodload zsh/complist
zstyle ':completion:*' menu select # Enable menu selection for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*' # Case-insensitive + substring matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Use LS_COLORS for completion listing
setopt auto_menu # Automatically show the completion menu on repeated tab
setopt no_list_beep # Don't beep when listing completions
bindkey '^[[Z' reverse-menu-complete # Shift-Tab cycles backward

# Ensure common keybindings work in all terminals
bindkey '^A' beginning-of-line # Ctrl-A
bindkey '^K' kill-line # Ctrl-K
bindkey '^?' backward-delete-char # Delete/Backspace
bindkey '^H' backward-delete-char # Backspace on some terminals
bindkey '^[[3~' delete-char # Forward delete

# Word navigation for common terminal sequences
bindkey '^[b' backward-word # Option-Left (Esc-b) jump by word
bindkey '^[f' forward-word # Option-Right (Esc-f) jump by word
bindkey '^[[1;3D' backward-word # Option-Left (xterm) jump by word
bindkey '^[[1;3C' forward-word # Option-Right (xterm) jump by word

# Line navigation for common terminal sequences
bindkey '^[[1;5D' beginning-of-line # Ctrl-Left jump to line start
bindkey '^[[1;5C' end-of-line # Ctrl-Right jump to line end
bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line # End
bindkey '^[OH' beginning-of-line # Home (xterm)
bindkey '^[OF' end-of-line # End (xterm)

# Key bindings for the "zsh-history-substring-search" plugin

# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
