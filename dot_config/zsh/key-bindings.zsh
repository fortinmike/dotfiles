# Completion menu selection
bindkey -e # Use emacs keybindings in the line editor
zmodload zsh/complist
zstyle ':completion:*' menu select # Enable menu selection for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*' # Case-insensitive + substring matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Use LS_COLORS for completion listing
zstyle ':completion:*' use-cache on # Cache completion results for speed
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/compcache" # Cache location
zstyle ':fzf-tab:*' fzf-flags --ignore-case # fzf-tab: force case-insensitive matching
setopt auto_menu # Automatically show the completion menu on repeated tab
setopt no_list_beep # Don't beep when listing completions
bindkey '^[[Z' reverse-menu-complete # Shift-Tab cycles backward

# fzf keybindings + completion (Ctrl-T, Ctrl-R, Alt-C)
source <("$("$BREW_BIN" --prefix fzf)/bin/fzf" --zsh)

# fzf-cd-widget alternative binding (keeps Option free for special characters)
bindkey '^Xc' fzf-cd-widget

# Ensure common keybindings work in all terminals
bindkey '^A' beginning-of-line # Ctrl-A
bindkey '^K' kill-line # Ctrl-K
bindkey '^?' backward-delete-char # Delete/Backspace
bindkey '^H' backward-delete-char # Backspace on some terminals
bindkey '^[[3~' delete-char # Forward delete

# Edit current command line in $VISUAL/$EDITOR (Ctrl-X Ctrl-E)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

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

# Key bindings for history search/navigation
zmodload zsh/terminfo

# Up arrow: use the same fzf history widget as Ctrl-R.
bindkey "$terminfo[kcuu1]" fzf-history-widget
bindkey '^[[A' fzf-history-widget

# Down arrow: keep inline history-substring behavior.
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[B' history-substring-search-down
