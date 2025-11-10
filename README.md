# Neovim Configuration - LazyVim

Personal LazyVim configuration optimized for full-stack development.

## Primary Project: climb-tracker

This configuration is tailored for the [climb-tracker](https://github.com/drewmarshburn/climb-tracker) project:
- **Backend**: Go 1.25 + Echo + GORM + templ templates
- **Frontend**: HTMX 1.9 + Tailwind CSS v4 + JavaScript
- **Testing**: Playwright (TypeScript)
- **Infrastructure**: Docker + PostgreSQL + Makefile

## Recommended Plugins for climb-tracker

### Priority 1: Essential Language Support

#### Go Development
```lua
-- File: lua/plugins/go.lua
return {
  -- Import LazyVim's Go extras (includes gopls, formatting, testing)
  { import = "lazyvim.plugins.extras.lang.go" },
}
```
**Why**: Provides gopls LSP, gofmt/goimports formatting, go test integration, and Go-specific keybindings. Essential for working with Echo, GORM, and standard library.

#### templ Template Support
```lua
-- File: lua/plugins/templ.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        templ = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "templ" },
    },
  },
}
```
**Why**: templ is Go's typed HTML template language. This adds syntax highlighting, LSP support for type checking, and proper indentation for your template files in `internal/templates/`.

#### Tailwind CSS v4 Support
```lua
-- File: lua/plugins/tailwind.lua
return {
  { import = "lazyvim.plugins.extras.lang.tailwindcss" },
}
```
**Why**: Provides intelligent Tailwind class completion, hover documentation, and CSS variable support. Critical for working with arbitrary values like `[var(--variable-name)]` in your project's dark theme.

### Priority 2: Enhanced Development Experience

#### TypeScript/JavaScript for Playwright
```lua
-- File: lua/plugins/typescript.lua
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
```
**Why**: Playwright tests use TypeScript. This provides tsserver LSP, ESLint integration, and proper support for test files in `tests/e2e/`.

#### Docker Support
```lua
-- File: lua/plugins/docker.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "dockerfile" })
    end,
  },
}
```
**Why**: Syntax highlighting and validation for your `docker-compose.yml` and Dockerfile configurations.

#### SQL/PostgreSQL Support
```lua
-- File: lua/plugins/sql.lua
return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      -- Add your connection: postgresql://user:password@localhost:5433/climb_tracker
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sqlls = {},
      },
    },
  },
}
```
**Why**: Direct PostgreSQL access from nvim for quick queries, schema inspection, and testing. Completion support when writing SQL in Go. Connects to your database on port 5433.

### Priority 3: Workflow Enhancement

#### Enhanced GitHub Integration (Already Installed)
You have `octo.nvim` configured, which is perfect for your PR-heavy workflow:
- `:Octo pr list` - View open PRs
- `:Octo pr view` - View current PR
- `:Octo pr comments` - View/respond to PR comments
- `:Octo pr create` - Create draft PRs

#### Better Git Integration
```lua
-- File: lua/plugins/git.lua
return {
  -- LazyVim includes lazygit by default, but let's ensure gitsigns is configured
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },
}
```
**Why**: Inline git blame helps track changes in your frequent commits. Already installed via LazyVim, this just enables blame view.

#### Makefile Support
```lua
-- File: lua/plugins/make.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "make" })
    end,
  },
}
```
**Why**: Proper syntax highlighting for your `Makefile` which is central to your build workflow (`make dev`, `make build-templ`, etc.).

### Priority 4: Quality of Life

#### HTMX Attribute Support
```lua
-- File: lua/plugins/htmx.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "html" })
    end,
  },
  -- Add HTMX attributes to HTML completion
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources or {}, {
        { name = "nvim_lsp" },
      }))
    end,
  },
}
```
**Why**: Better HTML support helps with HTMX attributes like `hx-get`, `hx-target`, `hx-swap` in your templ templates.

#### Auto-save on Focus Loss
```lua
-- File: lua/config/autocmds.lua (add to existing file)
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wa",
  desc = "Auto-save on focus loss",
})
```
**Why**: With frequent browser refreshing during HTMX development, auto-save prevents lost changes.

#### Project-Specific Settings
```lua
-- File: lua/config/options.lua (add to existing file)
vim.opt.tabstop = 4      -- Go uses tabs
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- Go prefers tabs
```
**Why**: Go convention uses tabs, not spaces. This matches your project's gofmt output.

### Priority 5: Testing & Debugging

#### Go Debugging (DAP)
```lua
-- File: lua/plugins/dap.lua
return {
  { import = "lazyvim.plugins.extras.dap.core" },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end,
    },
  },
}
```
**Why**: Set breakpoints in your Go handlers/services and step through GORM queries. Useful for debugging complex business logic in `internal/services/`.

#### Playwright Test Runner
```lua
-- File: lua/plugins/playwright.lua
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-playwright",
    },
    opts = {
      adapters = {
        ["neotest-playwright"] = {
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        },
      },
    },
  },
}
```
**Why**: Run Playwright tests directly from nvim, see results inline, and jump to failures. Better than switching to terminal for `npm run test:e2e`.

## Not Recommended (Already Covered by LazyVim)

- **File navigation**: Neo-tree (already installed), Telescope (LazyVim default)
- **LSP management**: Mason (LazyVim default)
- **Formatting**: Conform.nvim (LazyVim default)
- **Git UI**: Lazygit (LazyVim default)
- **Code actions**: Built into LazyVim LSP config

## Installation Order

1. **Essential** (Install first): Go, templ, Tailwind CSS
2. **Language Support** (Install next): TypeScript, Docker, SQL
3. **Workflow** (Install when ready): Git enhancements, Makefile
4. **Quality of Life** (Install as needed): HTMX, auto-save, project settings
5. **Advanced** (Install when debugging): DAP, Playwright test runner

## Quick Start

1. Create plugin files in `~/.config/nvim/lua/plugins/` as shown above
2. Restart nvim or run `:Lazy sync`
3. Install LSP servers: `:Mason` then search and install:
   - `gopls` (Go LSP)
   - `templ` (templ LSP)
   - `tailwindcss-language-server` (Tailwind LSP)
   - `typescript-language-server` (TypeScript LSP)
   - `sqlls` (SQL LSP)
4. Verify with `:LspInfo` in relevant file types

## Configuration Files

- `lua/plugins/*.lua` - Plugin specifications (create one file per category)
- `lua/config/options.lua` - Editor options and settings
- `lua/config/keymaps.lua` - Custom keybindings
- `lua/config/autocmds.lua` - Auto-commands and events
- `.ai-context.md` - Context for AI pair programming

## Keybindings

LazyVim includes sensible defaults. Key additions for climb-tracker workflow:

- `<leader>gg` - Open lazygit (already configured)
- `<leader>gh` - Open GitHub (via octo.nvim)
- `<leader>td` - Toggle DAP UI (after DAP setup)
- `<leader>db` - Toggle breakpoint (after DAP setup)

## Project-Specific Workflow

### Typical Development Session
1. Open nvim in project root: `cd ~/dev/climb-tracker && nvim`
2. Check git status: `<leader>gg` (lazygit)
3. Edit Go handler: Full LSP support, formatting on save
4. Edit templ template: Syntax highlighting, type checking
5. Check database: `:DBUI` to query PostgreSQL
6. Run tests: `:Neotest` for Playwright (if installed)
7. Create PR: `:Octo pr create` (already configured)

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>e` - Toggle Neo-tree file explorer

## Tool Integration

### mise-en-place
Your project uses mise for Go, Node, and other tools. Neovim will automatically use the versions specified in `.mise.toml`.

### GitHub CLI
Works seamlessly with `octo.nvim` - authenticate once with `gh auth login` and all Octo commands work.

### Docker
LSP servers will be installed locally via Mason, independent of your Docker database.

## Performance Notes

- LazyVim lazy-loads plugins - startup should remain fast
- templ LSP is lightweight
- Tailwind LSP indexes once per project
- Consider disabling features you don't use: `:LazyExtras` to review

## Troubleshooting

### LSP Not Working
1. Check `:LspInfo` in the file type
2. Verify installation: `:Mason`
3. Check logs: `:LspLog`
4. Restart LSP: `:LspRestart`

### templ Syntax Not Highlighting
1. Ensure treesitter parser installed: `:TSInstall templ`
2. Verify file type: `:set ft?` should show `templ`
3. Regenerate: `:TSUpdate`

### Tailwind Classes Not Completing
1. Check `tailwind.config.js` is in project root (✓ it is)
2. Verify Tailwind LSP running: `:LspInfo` in HTML/templ file
3. Tailwind v4 uses CSS first - ensure `static/css/input.css` exists

## References

- [LazyVim Documentation](https://www.lazyvim.org/)
- [LazyVim Extras](https://www.lazyvim.org/extras)
- [templ LSP](https://templ.guide/commands-and-tools/ide-support/)
- [climb-tracker Project](https://github.com/drewmarshburn/climb-tracker)

## AI Collaboration

See `.ai-context.md` for guidelines on working with AI assistants on this configuration.

Last updated: 2025-11-05
