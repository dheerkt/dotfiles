#!/bin/bash
# Minimal dotfiles installer
# Usage: ./install.sh [--work] (from cloned repo) or bash <(curl -s https://raw.githubusercontent.com/dheerkt/dotfiles/main/install.sh)

set -e

# Parse arguments
WORK=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --work)
            WORK=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

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
if [ -f "$HOME/.config/ghostty/config" ] && [ ! -L "$HOME/.config/ghostty/config" ]; then
    mv "$HOME/.config/ghostty/config" "$HOME/.config/ghostty/config.bak"
    echo "✅ Backed up existing ghostty config to ~/.config/ghostty/config.bak"
fi

# Backup existing opencode config
if [ -d "$HOME/.config/opencode" ] && [ ! -L "$HOME/.config/opencode" ]; then
    mv "$HOME/.config/opencode" "$HOME/.config/opencode.bak"
    echo "✅ Backed up existing opencode config to ~/.config/opencode.bak"
fi

# Create symlinks
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# OpenCode config - link entire directory based on mode
rm -rf "$HOME/.config/opencode"
if [ "$WORK" = true ]; then
    ln -sf "$DOTFILES_DIR/opencode-work" "$HOME/.config/opencode"
    echo "✅ Linked work OpenCode config"
else
    ln -sf "$DOTFILES_DIR/opencode" "$HOME/.config/opencode"
    echo "✅ Linked personal OpenCode config"
fi

echo "✅ Installation complete!"
echo ""
echo "Next: nvim (plugins will auto-install)"
