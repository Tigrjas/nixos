#!/usr/bin/env bash

set -euo pipefail

REPO="$HOME/nixos"

echo "==> Updating Nix flake inputs..."
cd "$REPO"
nix flake update

echo
echo "==> Rebuilding NixOS..."
sudo nixos-rebuild switch --flake "$REPO#nixos"

echo
echo "==> Update complete."
echo
git status --short
