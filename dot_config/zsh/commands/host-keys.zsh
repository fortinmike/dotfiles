HOST_KEYS_DIR=/etc/ssh/
HOST_ED25519_PUBLIC_KEY_PATH=$HOST_KEYS_DIR/ssh_host_ed25519_key.pub

_require_host_ed25519_public_key() {
  if [[ ! -f "$HOST_ED25519_PUBLIC_KEY_PATH" ]]; then
    echo "Host key not found: $HOST_ED25519_PUBLIC_KEY_PATH"
    echo "Verify the contents of $HOST_KEYS_DIR"
    return 1
  fi
}

host-key-sha256() {
  _require_host_ed25519_public_key || return $?
  ssh-keygen -lvf "$HOST_ED25519_PUBLIC_KEY_PATH"
}

host-key-md5() {
  _require_host_ed25519_public_key || return $?
  ssh-keygen -lvf "$HOST_ED25519_PUBLIC_KEY_PATH" -E md5
}
