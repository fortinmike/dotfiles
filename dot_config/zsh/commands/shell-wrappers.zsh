# These wrappers integrate osc52pty so that copying to the local Mac clipboard
# is possible in Terminal.app in an SSH session.

# Use osc52pty automatically for local Terminal.app SSH sessions.
# Wrapping SSH with osc52pty adds support for copying text to the local Mac clipboard in remote programs like micro.
ssh() {
  local osc52pty_bin="$HOME/.local/bin/osc52pty"
  if [[ "$OSTYPE" == darwin* && "$TERM_PROGRAM" == Apple_Terminal && -z "$SSH_TTY" ]]; then
    command "$osc52pty_bin" ssh "$@"
    return
  fi
  command ssh "$@"
}

# When micro is running in a SSH session (when this machine is accessed remotely through SSH),
# set micro to OSC 52 mode. This makes micro send the clipboard to the terminal which in turn propagates
# the string through osc52pty to the client Mac.
micro() {
  if [[ -n "$SSH_TTY" ]]; then
    command micro -clipboard terminal "$@"
    return
  fi
  command micro "$@"
}
