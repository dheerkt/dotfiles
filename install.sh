#!/bin/bash
# Minimal dotfiles installer
# Usage: ./install.sh (from cloned repo) or bash <(curl -s https://raw.githubusercontent.com/dheerkt/dotfiles/main/install.sh)

set -e

if [[ $# -ne 0 ]]; then
    echo "Usage: ./install.sh" >&2
    exit 1
fi

# Setup paths
if [ -n "$BASH_SOURCE" ]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    DOTFILES_DIR="$HOME/.dotfiles"
    git clone https://github.com/dheerkt/dotfiles.git "$DOTFILES_DIR"
fi

# Check for OpenCode conflicts before moving any files.
if [ -e "$HOME/.config/opencode" ] && [ ! -d "$HOME/.config/opencode" ] && [ ! -L "$HOME/.config/opencode" ]; then
    echo "Expected ~/.config/opencode to be a directory or symlink" >&2
    exit 1
fi
if [ -d "$HOME/.config/opencode" ] && [ ! -L "$HOME/.config/opencode" ] &&
   { [ -e "$HOME/.config/opencode.bak" ] || [ -L "$HOME/.config/opencode.bak" ]; }; then
    echo "OpenCode backup already exists at ~/.config/opencode.bak" >&2
    exit 1
fi

# Backup existing nvim config
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    echo "✅ Backed up existing nvim config to ~/.config/nvim.bak"
fi

# Backup existing ghostty config
if [ -f "$HOME/.config/ghostty/config" ] && [ ! -L "$HOME/.config/ghostty/config" ]; then
    mv "$HOME/.config/ghostty/config" "$HOME/.config/ghostty/config.bak"
    echo "✅ Backed up existing ghostty config to ~/.config/ghostty/config.bak"
fi

# Back up an existing OpenCode directory without overwriting a backup.
if [ -d "$HOME/.config/opencode" ] && [ ! -L "$HOME/.config/opencode" ]; then
    mv "$HOME/.config/opencode" "$HOME/.config/opencode.bak"
    echo "✅ Backed up existing opencode config to ~/.config/opencode.bak"
fi

# Create symlinks
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# OpenCode config
if [ -L "$HOME/.config/opencode" ]; then
    rm -f "$HOME/.config/opencode"
fi
ln -s "$DOTFILES_DIR/opencode" "$HOME/.config/opencode"
echo "✅ Linked personal OpenCode config"

echo "✅ Installation complete!"
echo ""
echo "Next: nvim (plugins will auto-install)"
