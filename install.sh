#!/bin/sh
#
# Installs the `ipify` CLI by symlinking ipify.sh into /usr/local/bin.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR" || exit 1
chmod +x "$SCRIPT_DIR/ipify.sh" || exit 1

rm -f "$BIN_DIR/ipify" || exit 1
ln -s "$SCRIPT_DIR/ipify.sh" "$BIN_DIR/ipify" || exit 1

echo "Installed: $BIN_DIR/ipify -> $SCRIPT_DIR/ipify.sh"
echo "Run 'ipify' to get your public IP."
