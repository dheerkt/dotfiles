# Dotfiles

Personal configuration files for development environment.

## Contents

- **nvim/** - Neovim configuration with LSP, telescope, and plugins
  - LSP support for Go, Python, TypeScript
  - Telescope fuzzy finder
  - Auto-completion with nvim-cmp
  - File explorer with neo-tree
  - Enhanced statusline with lualine

## Quick Install

```bash
# Clone the repo
git clone https://github.com/dheerkt/dotfiles.git

# Run the install script
cd dotfiles
./install.sh
```

The install script will:
1. Create symlinks for config files to your home directory
2. Check for required tools (git, neovim, etc)
3. Display setup instructions

## Manual Setup

If you prefer to set up manually:

```bash
# Neovim config
mkdir -p ~/.config
ln -s /path/to/dotfiles/nvim ~/.config/nvim
```

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
