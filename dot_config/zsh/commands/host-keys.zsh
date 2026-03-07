HOST_KEYS_DIR=/etc/ssh/
HOST_ED25519_PUBLIC_KEY_PATH=$HOST_KEYS_DIR/ssh_host_ed25519_key.pub

host-key-sha265() {
  if [[ ! -f "$HOST_ED25519_PUBLIC_KEY_PATH" ]]; then
    echo "Host key not found: $HOST_ED25519_PUBLIC_KEY_PATH"
    echo "Verify the contents of $HOST_KEYS_DIR"
    return 1
  fi

  ssh-keygen -lvf "$HOST_ED25519_PUBLIC_KEY_PATH"
}

host-key-md5() {
  if [[ ! -f "$HOST_ED25519_PUBLIC_KEY_PATH" ]]; then
    echo "Host key not found: $HOST_ED25519_PUBLIC_KEY_PATH"
    echo "Verify the contents of $HOST_KEYS_DIR"
    return 1
  fi

  ssh-keygen -lvf "$HOST_ED25519_PUBLIC_KEY_PATH" -E md5
}
