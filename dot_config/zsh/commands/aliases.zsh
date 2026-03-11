# Use eza for better defaults
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'

# Navigation helpers (OMZ-like)
setopt auto_cd # Allow typing a dir name to cd into it
setopt auto_pushd # Push dirs onto stack when changing
setopt pushd_ignore_dups # Avoid duplicate entries in dir stack
setopt pushd_minus # Swap meanings of +/- for dir stack

alias ..='cd ..' # Up one directory
alias ...='cd ../..' # Up two directories
alias ....='cd ../../..' # Up three directories
alias .....='cd ../../../..' # Up four directories

# Utility helpers
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"' # Generate a random lowercase UUID

# Grep color
alias grep='grep --color=auto' # Highlight matches

# Replace common commands with modern versions
alias bat='bat --style=plain' # Plain output: no header or line numbers
[[ -o interactive ]] && alias cat='bat' # Use bat only for interactive shells to avoid breaking scripts/pipelines

# Ripgrep helpers
alias rgf='rg --files' # List files rg would search
alias rgi='rg -i' # Case-insensitive search
alias rgl='rg -l' # List matching files only
alias rgw='rg -w' # Match whole words
alias rgh='rg --hidden --glob "!.git/*"' # Include hidden files, skip .git

# Git helpers
alias lg='lazygit'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias gl='git log --oneline --decorate --graph --all'
alias gp='git pull --ff-only'
alias gpr='git pull --rebase'
alias gpu='git push'

if [[ "$OSTYPE" == darwin* ]]; then
  alias reveal='open -R'
fi
