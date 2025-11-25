#!/bin/sh

# Usage: ./backup_nvim.sh [--nix|--home] <destination>
#   --nix  : backup /etc/nixos/home-modules/nvim/  (default)
#   --home : backup ~/.config/nvim/

set -e

usage() {
    echo "Usage: $0 [--nix|--home] <destination_directory>"
    exit 1
}

# Default
MODE="nix"

case "$1" in
    --nix)
        MODE="nix"
        ;;
    --home)
        MODE="home"
        ;;
    --help)
        MODE="help"
        ;;
esac

# Now we expect exactly one arg: DEST
[ $# -eq 1 ] || usage
DEST="$1"

# Pick source based on MODE
case "$MODE" in
    nix)
        SRC="/etc/nixos/home-modules/nvim/"
        ;;
    home)
        SRC="$HOME/.config/nvim/"
        ;;
esac

# Run rsync and chown using that source + destination
sudo rsync -a --delete "$SRC" "$DEST"
sudo chown -R "$USER:users" "$DEST"
