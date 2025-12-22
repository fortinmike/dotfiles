# Completion menu selection
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*'
setopt auto_menu
bindkey '^[[Z' reverse-menu-complete

# Key bindings for the "zsh-history-substring-search" plugin

# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
