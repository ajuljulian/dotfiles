# Neovim Configuration

This document describes my Neovim setup, including all plugins, keymaps, and configurations.

## Table of Contents

- [Core Settings](#core-settings)
- [Plugin Manager](#plugin-manager)
- [Plugins](#plugins)
- [Keymaps](#keymaps)
- [LSP Configuration](#lsp-configuration)
- [File Structure](#file-structure)

---

## Core Settings

My Neovim configuration is stored in `nvim/` and uses the following core settings:

### General Settings

| Setting | Value | Description |
|---------|-------|-------------|
| `mapleader` | `<Space>` | Leader key for custom mappings |
| `localleader` | `\` | Local leader key |
| `tabstop` | `2` | Number of spaces for tab |
| `shiftwidth` | `2` | Indentation width |
| `expandtab` | `true` | Use spaces instead of tabs |
| `number` | `true` | Show line numbers |
| `relativenumber` | `true` | Show relative line numbers |
| `cursorline` | `true` | Highlight current line |
| `hlsearch` | `true` | Highlight search results |
| `background` | `dark` | Dark background mode |
| `clipboard` | `unnamedplus` | Use system clipboard |
| `splitbelow` | `true` | Open new windows below |
| `splitright` | `true` | Open new windows to the right |
| `termguicolors` | `true` | Enable 24-bit colors |

### Colorscheme

- **Primary**: [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- Available variants: `tokyonight`, `tokyonight-day`, `tokyonight-moon`
- Toggle between light/dark: `<leader>csl` (light), `<leader>csd` (dark)

---

## Plugin Manager

**lazy.nvim** - A modern plugin manager for Neovim

- Repository: https://github.com/folke/lazy.nvim
- Configuration: `lua/config/lazy.lua`
- Plugins are loaded from `lua/config/plugins/`

---

## Plugins

### UI & Appearance

#### Tokyo Night (Colorscheme)
- **Repository**: `folke/tokyonight.nvim`
- **File**: `lua/config/plugins/plugins.lua`
- **Description**: A clean, dark Neovim theme with multiple variants
- **Priority**: 1000 (loads first)

---

### File Navigation

#### Neo-tree
- **Repository**: `nvim-neo-tree/neo-tree.nvim`
- **File**: `lua/config/plugins/neotree.lua`
- **Description**: A modern file explorer tree for Neovim
- **Dependencies**:
  - `nvim-lua/plenary.nvim`
  - `nvim-tree/nvim-web-devicons` (icons)
  - `MunifTanjim/nui.nvim`
- **Keymaps**:
  - `<C-Z>` - Toggle Neo-tree
  - `<leader>gg` - Toggle Git Status view
- **Options**:
  - `close_if_last_window = true` - Close when it's the last window

#### Telescope
- **Repository**: `nvim-telescope/telescope.nvim`
- **File**: `lua/config/plugins/plugins.lua`
- **Description**: Fuzzy finder over lists
- **Dependencies**: `nvim-lua/plenary.nvim`
- **Keymaps**:
  - `<leader>ff` - Find files
  - `<leader>fg` - Live grep
  - `<leader>fb` - List buffers
  - `<leader>fh` - Help tags

---

### Git Integration

#### Neogit
- **Repository**: `NeogitOrg/neogit`
- **File**: `lua/config/plugins/neogit.lua`
- **Description**: A magit-like Git interface for Neovim
- **Dependencies**:
  - `nvim-lua/plenary.nvim`
  - `sindrets/diffview.nvim` (diff integration)
  - `nvim-telescope/telescope.nvim`
- **Keymaps**:
  - `<leader>gs` - Open Neogit

#### Gitsigns
- **Repository**: `lewis6991/gitsigns.nvim`
- **File**: `lua/config/plugins/gitsigns.lua`
- **Description**: Git decorations for buffers
- **Features**:
  - Shows git status in the sign column
  - Navigate between hunks
  - Stage/reset hunks
  - Blame line
  - Diff view
- **Keymaps**:
  - `]c` - Next hunk
  - `[c` - Previous hunk
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
  - `<leader>hS` - Stage buffer
  - `<leader>hR` - Reset buffer
  - `<leader>hp` - Preview hunk
  - `<leader>hi` - Preview hunk inline
  - `<leader>hb` - Blame line (full)
  - `<leader>hd` - Diff this
  - `<leader>hD` - Diff this (~)
  - `<leader>tb` - Toggle current line blame
  - `<leader>tw` - Toggle word diff
  - `ih` - Select hunk (text object)
  - `<leader>gx` - Diff current file (from Neogit)
  - `<leader>gd` - Gitsigns diff current file

#### Fugitive
- **Repository**: `tpope/vim-fugitive`
- **File**: `lua/config/plugins/plugins.lua`
- **Description**: A Git wrapper for Vim
- **Keymaps**:
  - `<leader>gb` - Git blame
  - `<leader>gl` - Git log for current line

---

### Editing & Text Objects

#### Mini.nvim
- **Repository**: `echasnovski/mini.nvim`
- **File**: `lua/config/plugins/mini.lua`
- **Description**: Collection of minimal, fast Lua modules
- **Enabled Modules**:
  - `mini.ai` - Better text objects (around/inside)
  - `mini.surround` - Surround text with characters
  - `mini.pairs` - Auto-close brackets
  - `mini.indentscope` - Indent scope visualization
  - `mini.jump` - Enhanced f/t motions
  - `mini.move` - Move selections
  - `mini.bufremove` - Better buffer deletion

#### Comment.nvim
- **Repository**: `numToStr/Comment.nvim`
- **File**: `lua/config/plugins/comment.lua`
- **Description**: Smart and powerful comment plugin
- **Features**: Toggle comments with `gcc` (line) and `gbc` (block)

#### Marks
- **Repository**: `chentoast/marks.nvim`
- **File**: `lua/config/plugins/plugins.lua`
- **Description**: A better user experience for viewing and interacting with Vim marks

---

### Completion & Formatting

#### Blink.cmp (Completion)
- **Repository**: `saghen/blink.cmp`
- **File**: `lua/config/plugins/completion.lua`
- **Description**: A fast, extensible completion engine
- **Dependencies**: `rafamadriz/friendly-snippets`
- **Keymaps**:
  - `<C-p>` - Select previous
  - `<C-n>` - Select next
  - `<CR>` - Accept completion
  - `<C-e>` - Hide completion
- **Sources**: LSP, path, snippets, buffer
- **Features**:
  - Menu with rounded border
  - Auto-show documentation (200ms delay)
  - Treesitter highlighting for LSP items

#### Neoformat (Formatting)
- **Repository**: `sbdchd/neoformat`
- **Files**: `lua/config/plugins/plugins.lua`, `lua/config/neoformat.lua`
- **Description**: A code formatter plugin
- **Enabled Formatters**:
  - JavaScript: `prettier`, `eslint_d`
  - Python: `autopep8`, `yapf`, `docformatter`
  - CSS: `prettier`
  - YAML: `prettier`
  - Lua: `stylua`
- **Features**:
  - Auto-format on save
  - Runs all formatters
  - Silent fallback on errors

---

### AI Integration

#### Opencode.nvim
- **Repository**: `NickvanDyke/opencode.nvim`
- **File**: `lua/config/plugins/opencode.lua`
- **Description**: Opencode integration for Neovim
- **Dependencies**: `folke/snacks.nvim`
- **Keymaps**:
  - `<leader>oa` - Ask about this
  - `<leader>o+` - Add this
  - `<leader>os` - Select prompt
  - `<leader>ot` - Toggle embedded
  - `<leader>oc` - Select command
  - `<leader>on` - New session
  - `<leader>oi` - Interrupt session
  - `<leader>oA` - Cycle selected agent
  - `<S-C-u>` - Messages half page up
  - `<S-C-d>` - Messages half page down

---

## Keymaps

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc><Esc>` | n | Clear search highlight |
| `<leader>b` | n,v | List and switch buffers |
| `<leader>ev` | n | Edit vim config (vsplit) |
| `<leader>u` | n | Uppercase current word |
| `<leader>q` | n | Close buffer |
| `<leader><leader>s` | n | Source vimrc |
| `<leader>c` | n | Toggle cursor column |
| `<A-h>` | n,i,t | Back to previous window |

### Window Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<C-J>` | n | Move to window below |
| `<C-K>` | n | Move to window above |
| `<C-L>` | n | Move to window right |
| `<C-H>` | n | Move to window left |

### Buffer Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<S-L>` | n,v | Next buffer |
| `<S-H>` | n,v | Previous buffer |

### Tab Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>1-9` | n | Go to tab 1-9 |
| `<leader>0` | n | Go to last tab |

### Colorscheme Toggle

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>csl` | n | Change to light theme (tokyonight-day) |
| `<leader>csd` | n | Change to dark theme (tokyonight-moon) |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to Definition |
| `gi` | n | Go to Implementation |
| `gh` | n | LSP Finder (Lspsaga) |
| `<leader>ca` | n,v | Code Action |

---

## LSP Configuration

The LSP is configured through the plugins. Key LSP-related plugins:

- **Blink.cmp** handles completion with LSP as a source
- **Gitsigns** provides git-related LSP features
- Built-in Neovim LSP client is used for go-to-definition and implementation

### External LSP Dependencies (from README)

- **Python**: `npm i -g pyright`
- **TypeScript**: `npm install -g typescript typescript-language-server`
- **Bash**: `npm i -g bash-language-server`
- **Go**: `brew install go && brew install gopls`

---

## File Structure

```
nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin lockfile
├── vscode/
│   └── settings.vim           # VSCode Neovim integration
├── lua/
│   ├── keymappings.lua       # All keymaps
│   ├── auto_reload.lua        # Auto-reload utilities
│   ├── tools.lua              # Utility functions
│   ├── whid.lua               # Custom plugin
│   ├── autocommands/          # Autocommand examples
│   │   ├── example1.lua
│   │   └── example2.lua
│   ├── config/
│   │   ├── lazy.lua           # Plugin manager setup
│   │   ├── neoformat.lua      # Formatting configuration
│   └── plugins/               # Plugin configurations
│       ├── plugins.lua        # Main plugin list
│       ├── completion.lua     # Blink.cmp config
│       ├── comment.lua        # Comment.nvim config
│       ├── gitsigns.lua       # Gitsigns config
│       ├── mini.lua           # Mini.nvim config
│       ├── neogit.lua         # Neogit config
│       ├── neotree.lua        # Neo-tree config
│       └── opencode.lua       # Opencode config
└── plugin/
    └── whid.vim               # Custom plugin vimscript
```

---

## Installation

To use this Neovim configuration:

1. Install Neovim: `brew install neovim`
2. Install Python support: `pip install neovim`
3. Install Node.js support: `npm install -g neovim`
4. Create symlink:
   ```bash
   ln -s ~/Development/configs/nvim ~/.config/nvim
   ```
5. Launch Neovim: `nvim`
6. Lazy.nvim will auto-install on first launch
7. Run `:checkhealth` to verify setup

---

## External Dependencies

See the [main README](../README.md) for a full list of external dependencies including:
- ranger
- ripgrep
- fd
- LSP servers
- Prettier
- Formatters (stylua, etc.)
