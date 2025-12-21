#!/bin/sh
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -x "$(command -v git)" ]; then
  echo "git is required but not installed." >&2
  exit 1
fi

if ! command -v chezmoi >/dev/null 2>&1; then
  if [ -x "$(command -v brew)" ]; then
    brew install chezmoi
  elif [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y chezmoi
  elif [ -x "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://chezmoi.io/get)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
  else
    echo "chezmoi is required but could not be installed (missing brew/apt-get/curl)." >&2
    exit 1
  fi
fi

chezmoi init --apply "$REPO_DIR"
