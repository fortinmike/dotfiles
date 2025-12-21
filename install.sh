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
  else
    echo "chezmoi is required but could not be installed (missing brew/apt-get)." >&2
    exit 1
  fi
fi

if chezmoi source-path >/dev/null 2>&1; then
  CURRENT_SOURCE="$(chezmoi source-path)"
  echo "chezmoi is already initialized at $CURRENT_SOURCE" >&2
  echo "Run 'chezmoi apply' or 'chezmoi update' instead." >&2
  exit 1
fi

chezmoi init --apply "$REPO_DIR"
