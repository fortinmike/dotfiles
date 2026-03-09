_starship_derive_text_color() {
  local hex=${1#\#} r g b
  (( r = 16#${hex[1,2]} * 20 / 100 ))
  (( g = 16#${hex[3,4]} * 20 / 100 ))
  (( b = 16#${hex[5,6]} * 20 / 100 ))
  printf '#%02x%02x%02x' "$r" "$g" "$b"
}

STARSHIP_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
STARSHIP_CONFIG_PATH="$STARSHIP_CONFIG_DIR/starship.toml"
STARSHIP_TEMPLATE_PATH="$(chezmoi source-path)/.manualtemplates/starship.toml"
STARSHIP_HOST_COLOR_DEFAULT='#7f8489'
STARSHIP_HOST_TEXT_COLOR_DEFAULT='#191a1b'

# Build the runtime starship config from the repo template, then apply any
# machine-local env var replacements before starship starts
starship_config_contents=$(<"$STARSHIP_TEMPLATE_PATH")

# Keep overrides grouped by concern so new env-backed replacements can be
# added as copy-paste blocks without changing the overall flow
starship_host_color="${PROMPT_HOST_COLOR:-$STARSHIP_HOST_COLOR_DEFAULT}"
starship_host_text_color="$(_starship_derive_text_color "$starship_host_color")"

# Prompt colors
starship_config_contents=${starship_config_contents//"color_host = '$STARSHIP_HOST_COLOR_DEFAULT'"/"color_host = '$starship_host_color'"}
starship_config_contents=${starship_config_contents//"color_host_text = '$STARSHIP_HOST_TEXT_COLOR_DEFAULT'"/"color_host_text = '$starship_host_text_color'"}

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
