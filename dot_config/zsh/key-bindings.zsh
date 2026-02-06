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
typeset -g _history_up_or_fzf_saved_buffer=""
typeset -gi _history_up_or_fzf_saved_cursor=0
typeset -gi _history_up_or_fzf_armed=0

# Up arrow:
# - Empty prompt: first Up recalls latest history, second Up opens unfiltered fzf.
# - Non-empty prompt: open fzf history immediately, using prompt text as query.
_history_up_or_fzf() {
  # Second Up after empty-prompt recall: open fzf with an empty query.
  if (( _history_up_or_fzf_armed )) && [[ $LASTWIDGET == _history_up_or_fzf ]]; then
    local FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--height 40% --layout=default --with-nth=2.."
    BUFFER=""
    zle fzf-history-widget
    local _fzf_status=$?
    _history_up_or_fzf_armed=0
    if (( _fzf_status == 0 )); then
      zle accept-line
      return 0
    fi
    BUFFER=$_history_up_or_fzf_saved_buffer
    CURSOR=$_history_up_or_fzf_saved_cursor
    return 0
  fi

  # Non-empty prompt: open fzf immediately, using current prompt text as query.
  if [[ -n $BUFFER ]]; then
    _history_up_or_fzf_saved_buffer=$BUFFER
    _history_up_or_fzf_saved_cursor=$CURSOR
    _history_up_or_fzf_armed=0
    local FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--height 40% --layout=default --with-nth=2.."
    zle fzf-history-widget
    local _fzf_status=$?
    if (( _fzf_status == 0 )); then
      # Enter in fzf selected a command; run it immediately.
      zle accept-line
      return 0
    fi
    # fzf canceled: restore the prompt exactly as it was before opening fzf.
    BUFFER=$_history_up_or_fzf_saved_buffer
    CURSOR=$_history_up_or_fzf_saved_cursor
    return 0
  fi

  # Empty prompt: recall latest history entry once.
  _history_up_or_fzf_saved_buffer=$BUFFER
  _history_up_or_fzf_saved_cursor=$CURSOR
  _history_up_or_fzf_armed=1

  BUFFER=$(fc -ln -1 2>/dev/null)
  if [[ -n $BUFFER ]]; then
    CURSOR=${#BUFFER}
  else
    zle up-line-or-history
  fi
}
zle -N _history_up_or_fzf
bindkey "$terminfo[kcuu1]" _history_up_or_fzf
bindkey '^[[A' _history_up_or_fzf

# Down arrow: if first-Up recall is active, restore original prompt once.
_history_down_or_restore() {
  if (( _history_up_or_fzf_armed )); then
    BUFFER=$_history_up_or_fzf_saved_buffer
    CURSOR=$_history_up_or_fzf_saved_cursor
    _history_up_or_fzf_armed=0
  else
    zle down-line-or-history
  fi
}
zle -N _history_down_or_restore
bindkey "$terminfo[kcud1]" _history_down_or_restore
bindkey '^[[B' _history_down_or_restore
