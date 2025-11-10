# Installation Guide - climb-tracker Neovim Setup

All plugin configurations have been created. Follow these steps to complete the setup.

## Quick Start

1. **Restart Neovim** or run `:Lazy sync` to install all plugins
2. **Wait for plugins to install** (first time will take a few minutes)
3. **Install LSP servers** via Mason (see below)
4. **Verify setup** by opening files from climb-tracker

## Step-by-Step Installation

### 1. Plugin Installation

```vim
" Open nvim and run:
:Lazy sync

" Or restart nvim - LazyVim will auto-install on startup
```

This will install:
- LazyVim Go extras (gopls, gofmt, delve)
- LazyVim TypeScript extras (tsserver, ESLint)
- LazyVim Tailwind CSS extras (tailwindcss-language-server)
- vim-dadbod (database UI)
- gitsigns (git integration)
- All Treesitter parsers

### 2. LSP Server Installation

Open Mason and install required language servers:

```vim
:Mason
```

**Required servers** (search and press `i` to install):
- `gopls` - Go language server
- `templ` - templ template language server
- `tailwindcss-language-server` - Tailwind CSS IntelliSense
- `typescript-language-server` - TypeScript/JavaScript LSP
- `sqlls` - SQL language server
- `html-lsp` - HTML language server
- `emmet-ls` - Emmet abbreviations
- `docker-compose-language-service` - docker-compose.yml support

**Optional servers**:
- `delve` - Go debugger (for DAP)

### 3. Verify Installation

Test each language support by opening relevant files:

```bash
cd ~/dev/climb-tracker

# Test Go support
nvim cmd/server/main.go
# Should see: gopls in :LspInfo

# Test templ support
nvim internal/templates/pages/workout.templ
# Should see: templ in :LspInfo

# Test Tailwind support
nvim internal/templates/components/workout.templ
# Should see: tailwindcss in :LspInfo, class completion working

# Test TypeScript support
nvim tests/e2e/smoke/critical-path.spec.ts
# Should see: tsserver in :LspInfo

# Test SQL support (create a .sql file or use DBUI)
:DBUI
```

### 4. Database Configuration (Optional)

To use vim-dadbod-ui for PostgreSQL access:

```vim
" Add to ~/.config/nvim/lua/config/options.lua or create a separate file:
vim.g.dbs = {
  climb_tracker = "postgresql://climb_tracker_user:climb_tracker_pass@localhost:5433/climb_tracker"
}

" Then use:
:DBUIToggle
```

Update credentials to match your `.env` file.

### 5. Test Key Features

#### Go Development
```vim
" Open a Go file
nvim internal/services/workout_service.go

" Test features:
" - Code completion (should see GORM methods)
" - Go to definition (gd on a function)
" - Format on save (should auto-format with gofmt)
" - Error checking (try adding invalid syntax)
```

#### templ Templates
```vim
" Open a templ file
nvim internal/templates/components/workout.templ

" Test features:
" - Syntax highlighting (Go code in HTML should be colored)
" - Type checking (pass wrong type to template variable)
" - Go to definition (jump to component definitions)
```

#### Tailwind CSS
```vim
" Open any template file
nvim internal/templates/pages/workout.templ

" Test features:
" - Type 'class="' and start typing Tailwind classes
" - Hover over a class to see CSS output
" - Try arbitrary values: class="w-[var(--custom)]"
```

#### Git Integration
```vim
" Open any file in git repo
nvim cmd/server/main.go

" Features:
" - Inline blame should appear after cursor line
" - Change indicators in sign column
" - Open lazygit with <leader>gg
```

## Troubleshooting

### LSP Not Starting

```vim
" Check LSP status
:LspInfo

" Check logs
:LspLog

" Restart LSP
:LspRestart
```

### Treesitter Errors

```vim
" Update all parsers
:TSUpdate

" Install specific parser
:TSInstall go
:TSInstall templ
:TSInstall html
```

### Plugin Not Loading

```vim
" Check plugin status
:Lazy

" Reload plugins
:Lazy reload

" Clean and reinstall
:Lazy clean
:Lazy sync
```

### templ LSP Not Working

1. Ensure templ is installed: `which templ` (should be in mise)
2. Install LSP: `:Mason` → search `templ` → press `i`
3. Restart nvim
4. Open `.templ` file and check `:LspInfo`

### Tailwind Not Completing

1. Ensure `tailwind.config.js` exists in project root ✓
2. Ensure `static/css/input.css` exists ✓
3. Install LSP: `:Mason` → search `tailwindcss` → press `i`
4. Open template file with Tailwind classes
5. Check `:LspInfo` shows tailwindcss attached

## Optional Plugins

### DAP (Debugging)

If you want to use the debugger:

```vim
" The plugin is installed but requires delve
" Install via mise or Mason:
:Mason
" Search for 'delve' and install

" Then use debugging commands:
" <leader>db - Set breakpoint
" <leader>dc - Continue
" <leader>di - Step into
" <leader>do - Step over
```

### Playwright Test Runner

If you want to run tests from nvim:

```vim
" Plugin is installed, test with:
" <leader>tt - Run nearest test
" <leader>tf - Run file tests
" <leader>ts - Run test suite
" <leader>tS - Toggle test summary
```

## Next Steps

1. **Read the README**: `~/.config/nvim/README.md` for full plugin documentation
2. **Customize keybindings**: Edit `~/.config/nvim/lua/config/keymaps.lua`
3. **Adjust settings**: Edit `~/.config/nvim/lua/config/options.lua`
4. **Explore LazyVim**: `:LazyExtras` to see more available extras

## Quick Reference

### Essential Commands

```vim
:Lazy          " Plugin manager
:Mason         " LSP/tool installer
:LspInfo       " Check LSP status
:LspRestart    " Restart LSP
:TSUpdate      " Update Treesitter
:DBUI          " Open database UI
:Octo pr list  " List GitHub PRs

" LazyVim defaults:
<leader>ff     " Find files
<leader>fg     " Live grep
<leader>e      " File explorer
<leader>gg     " Lazygit
```

### Plugin Files Created

All plugins are in `~/.config/nvim/lua/plugins/`:
- `go.lua` - Go development (Priority 1)
- `templ.lua` - templ templates (Priority 1)
- `tailwind.lua` - Tailwind CSS (Priority 1)
- `typescript.lua` - TypeScript for Playwright (Priority 1)
- `docker.lua` - Docker syntax (Priority 2)
- `sql.lua` - PostgreSQL access (Priority 2)
- `git.lua` - Enhanced git integration (Priority 2)
- `make.lua` - Makefile support (Priority 2)
- `htmx.lua` - HTMX attribute support (Priority 3)
- `dap.lua` - Go debugging (Optional)
- `playwright.lua` - Test runner (Optional)

### Config Files Modified

- `lua/config/options.lua` - Added Go tab settings
- `lua/config/autocmds.lua` - Added auto-save on focus loss

## Support

If you encounter issues:
1. Check `:checkhealth` for system-wide issues
2. Check `:LspInfo` for language server status
3. Check `:Lazy` for plugin installation status
4. Review plugin comments in `lua/plugins/*.lua` for usage notes

---

Configuration complete! Happy coding on climb-tracker! 🧗
