#!/bin/bash
# Minimal dotfiles installer
# Usage: ./install.sh (from cloned repo) or bash <(curl -s https://raw.githubusercontent.com/dheerkt/dotfiles/main/install.sh)

set -e

# Setup paths
if [ -n "$BASH_SOURCE" ]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    DOTFILES_DIR="$HOME/.dotfiles"
    git clone https://github.com/dheerkt/dotfiles.git "$DOTFILES_DIR"
fi

# Backup existing nvim config
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    echo "✅ Backed up existing nvim config to ~/.config/nvim.bak"
fi

# Backup existing ghostty config
GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
if [ -d "$GHOSTTY_CONFIG_DIR" ] && [ ! -L "$GHOSTTY_CONFIG_DIR/config" ]; then
    mv "$GHOSTTY_CONFIG_DIR/config" "$GHOSTTY_CONFIG_DIR/config.bak"
    echo "✅ Backed up existing ghostty config to $GHOSTTY_CONFIG_DIR/config.bak"
fi

# Create symlinks
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

mkdir -p "$GHOSTTY_CONFIG_DIR"
ln -sf "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"

echo "✅ Installation complete!"
echo ""
echo "Next: nvim (plugins will auto-install)"
