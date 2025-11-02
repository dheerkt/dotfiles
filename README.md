# Dotfiles

Personal configuration files for development environment.

## Contents

- **nvim/** - Neovim configuration with LSP, telescope, and plugins
  - LSP support for Go, Python, TypeScript
  - Telescope fuzzy finder
  - Auto-completion with nvim-cmp
  - File explorer with neo-tree
  - Enhanced statusline with lualine

## Install

**From a new machine:**
```bash
bash <(curl -s https://raw.githubusercontent.com/dheerkt/dotfiles/main/install.sh)
```

**After cloning:**
```bash
git clone https://github.com/dheerkt/dotfiles.git
cd dotfiles
./install.sh
nvim
```

The install script creates a symlink to your neovim config. That's it!

## Requirements

- Neovim 0.11+
- Git
- Node.js (for TypeScript/Python LSP servers)
- Go (optional, for Go development)

## First Time Setup

After running the install script:

1. Open Neovim: `nvim`
2. Wait for plugins to install (lazy.nvim will auto-install)
3. Check health: `:checkhealth`
4. LSP servers will install automatically via Mason when you open files

## Updating

```bash
cd ~/dotfiles
git pull
nvim +Lazy +update +quit  # Update plugins
```

## Notes

- Go, Python, TypeScript language servers are pre-configured
- Plugins managed with lazy.nvim
- Configuration is in `nvim/init.lua`
