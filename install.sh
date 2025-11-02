#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "   Dotfiles Installation Script      "
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check required tools
echo "📋 Checking required tools..."
echo ""

MISSING_TOOLS=()

command -v git >/dev/null 2>&1 || MISSING_TOOLS+=("git")
command -v nvim >/dev/null 2>&1 || MISSING_TOOLS+=("neovim")

if [ ${#MISSING_TOOLS[@]} -ne 0 ]; then
    echo -e "${RED}❌ Missing required tools:${NC}"
    for tool in "${MISSING_TOOLS[@]}"; do
        echo "   - $tool"
    done
    echo ""
    echo "Please install the missing tools and try again."
    exit 1
fi

echo -e "${GREEN}✅ All required tools found${NC}"
echo ""

# Create symlinks
echo "🔗 Creating symlinks..."
echo ""

# Neovim config
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo -e "${YELLOW}⚠️  ~/.config/nvim already exists (not a symlink)${NC}"
    echo "   Backing up to ~/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo -e "${GREEN}✅${NC} Neovim config linked"

echo ""
echo "======================================"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo "======================================"
echo ""

echo "📝 Next steps:"
echo ""
echo "1. Open Neovim to auto-install plugins:"
echo "   nvim"
echo ""
echo "2. Check health:"
echo "   :checkhealth"
echo ""
echo "3. Install global tools (optional):"
echo "   npm install -g typescript-language-server pyright"
echo ""
echo "4. If you haven't installed LSP servers, Mason will prompt you:"
echo "   - Open a .go file → gopls will install"
echo "   - Open a .py file → pyright will install"
echo "   - Open a .ts/.js file → ts_ls will install"
echo ""
echo "5. Check available commands:"
echo "   Press <space> and wait to see all keybindings"
echo ""
