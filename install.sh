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

# Backup existing config
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    echo "✅ Backed up existing nvim config to ~/.config/nvim.bak"
fi

# Create symlink
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "✅ Installation complete!"
echo ""
echo "Next: nvim  (plugins will auto-install)"
