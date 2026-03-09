STARSHIP_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
STARSHIP_CONFIG_PATH="$STARSHIP_CONFIG_DIR/starship.toml"
STARSHIP_TEMPLATE_PATH="$(chezmoi source-path)/.manualtemplates/starship.toml"
STARSHIP_HOST_COLOR_DEFAULT='#7f8489'

# Build the runtime starship config from the repo template, then apply any
# machine-local env var replacements before starship starts
starship_config_contents=$(<"$STARSHIP_TEMPLATE_PATH")

# Keep overrides grouped by concern so new env-backed replacements can be
# added as copy-paste blocks without changing the overall flow
if [[ -n "$PROMPT_HOST_COLOR" ]]; then
  starship_config_contents=${starship_config_contents//"color_host = '$STARSHIP_HOST_COLOR_DEFAULT'"/"color_host = '$PROMPT_HOST_COLOR'"}
fi

# Only rewrite the generated config when the rendered contents actually changed
starship_config_current_contents=
if [[ -e "$STARSHIP_CONFIG_PATH" ]]; then
  starship_config_current_contents=$(<"$STARSHIP_CONFIG_PATH")
fi
if [[ "$starship_config_contents" != "$starship_config_current_contents" ]]; then
  mkdir -p "$STARSHIP_CONFIG_DIR"
  printf '%s' "$starship_config_contents" >| "$STARSHIP_CONFIG_PATH"
fi

# Use starship's explicit homebrew path because homebrew might not yet
# have added its paths to PATH at this point
STARSHIP_BIN="$("$BREW_BIN" --prefix starship)/bin/starship"
eval "$("$STARSHIP_BIN" init zsh)"
