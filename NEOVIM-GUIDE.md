# Neovim with LazyVim: A Practical Guide

**A VSCode User's Journey to Modal Editing**

---

## Table of Contents

**Part I: Foundations**
1. [Understanding Neovim](#chapter-1-understanding-neovim)
2. [Modal Editing Philosophy](#chapter-2-modal-editing-philosophy)
3. [LazyVim: A Modern Foundation](#chapter-3-lazyvim-a-modern-foundation)

**Part II: Core Concepts**
4. [The Plugin Ecosystem](#chapter-4-the-plugin-ecosystem)
5. [Language Server Protocol (LSP)](#chapter-5-language-server-protocol-lsp)
6. [Buffers, Windows, and Tabs](#chapter-6-buffers-windows-and-tabs)

**Part III: Essential Tools**
7. [The Quickfix List](#chapter-7-the-quickfix-list)
8. [Terminal Emulator](#chapter-8-terminal-emulator)
9. [File Navigation](#chapter-9-file-navigation)

**Part IV: Your Configuration**
10. [Your LazyVim Setup](#chapter-10-your-lazyvim-setup)
11. [Language-Specific Features](#chapter-11-language-specific-features)
12. [Workflow Integration](#chapter-12-workflow-integration)

**Part V: Practical Application**
13. [Daily Development Workflow](#chapter-13-daily-development-workflow)
14. [Advanced Techniques](#chapter-14-advanced-techniques)
15. [Troubleshooting](#chapter-15-troubleshooting)

**Appendices**
- [Appendix A: VSCode to Neovim Mapping](#appendix-a-vscode-to-neovim-mapping)
- [Appendix B: Your Configuration Files](#appendix-b-your-configuration-files)
- [Appendix C: Essential Commands Reference](#appendix-c-essential-commands-reference)

**[Index](#index)**

---

## Chapter 1: Understanding Neovim

### What Neovim Is

Neovim is a refactored and modernized version of Vim, the text editor that has dominated terminal-based editing since the 1990s. Unlike graphical editors such as VSCode, Neovim operates primarily in the terminal and embraces a fundamentally different editing philosophy: modal editing.

The "neo" in Neovim represents more than modernization. Released in 2014, Neovim addressed Vim's architectural limitations by:

- Implementing a true client-server architecture
- Adding first-class Lua scripting support alongside Vimscript
- Creating a robust plugin API with asynchronous capabilities
- Enabling external UI integration while maintaining terminal compatibility

### Why Neovim Exists

Vim's original codebase, dating to 1991, accumulated technical debt that made certain improvements difficult. Neovim's founders initiated a fork to enable:

**Extensibility**: Lua provides a faster, more maintainable scripting language than Vimscript. Your configuration files in `~/.config/nvim/lua/` leverage this modern foundation.

**Asynchronous Operations**: Unlike traditional Vim, Neovim can execute background tasks without blocking the editor. This enables features like non-blocking LSP servers and asynchronous syntax checking.

**Plugin Ecosystem**: The built-in LSP client and standardized plugin architecture spawned modern plugin managers like lazy.nvim, which powers your LazyVim setup.

### Core Architecture

Neovim operates on several key principles:

**Configuration as Code**: Your `~/.config/nvim/` directory contains Lua programs that configure the editor. The `init.lua` file bootstraps this system, loading configurations from `lua/config/` and plugins from `lua/plugins/`.

**Buffer-Centric Model**: Neovim loads files into memory buffers, which exist independently of windows. A single file can appear in multiple windows, and windows can switch between buffers without reloading files.

**Process Separation**: LSP servers, formatters, and linters run as separate processes communicating via RPC (Remote Procedure Call). This isolation prevents editor crashes and enables language-agnostic tooling.

### Neovim vs. VSCode

The comparison reveals different philosophies:

| Aspect | VSCode | Neovim |
|--------|--------|--------|
| Interface | Graphical, mouse-driven | Terminal, keyboard-driven |
| Configuration | JSON settings, GUI | Lua programs, code |
| Extension Model | Marketplace, sandboxed | Open plugins, direct access |
| Resource Usage | ~200-400MB typical | ~20-50MB typical |
| Customization Depth | Settings and extensions | Complete control via Lua |
| Learning Curve | Gentle, familiar | Steep, requires commitment |

VSCode excels at immediate productivity with minimal configuration. Neovim rewards investment with unparalleled efficiency for those who master its paradigm.

### The Terminal Context

Neovim's terminal heritage provides distinct advantages:

**SSH-Native**: Edit files on remote servers as naturally as local files. Your entire configuration follows you through SSH.

**Composability**: Pipe text through Unix tools, integrate with tmux or shell scripts, and leverage the terminal ecosystem.

**Performance**: Terminal rendering is inherently faster than complex GUI layouts, particularly over network connections.

Your LazyVim setup in `~/.config/nvim/` maintains these advantages while providing modern IDE features through LSP integration.

### What Makes Neovim Modern

Contemporary Neovim, especially with LazyVim, bridges traditional terminal editing with modern development expectations:

- **LSP Integration**: Your `gopls` and `templ` LSP servers provide VSCode-quality code intelligence
- **Treesitter Parsing**: Syntax-aware editing and highlighting using formal language grammars
- **Plugin Management**: lazy.nvim offers dependency resolution and lazy loading
- **UI Enhancements**: Plugins like Neo-tree and Telescope provide familiar file navigation

The editor you've configured represents this modern synthesis: terminal-based efficiency with contemporary IDE capabilities.

---

## Chapter 2: Modal Editing Philosophy

### The Modal Paradigm

Modal editing represents Neovim's most significant departure from traditional editors. Rather than modifying text while typing (VSCode's approach), Neovim separates editing into distinct modes, each optimized for specific tasks.

This design emerged from Vi's creation in 1976 on ADM-3A terminals, which lacked arrow keys and function keys. The constraint became a feature: keeping hands on the home row maximizes efficiency.

### The Four Essential Modes

**Normal Mode** (default state): Navigate and manipulate text using single-key commands. Press `Esc` from any mode to return here. The cursor represents a position in the text, not an insertion point.

**Insert Mode** (entered via `i`, `a`, `o`, etc.): Traditional typing. Text appears as you type, similar to VSCode. This mode should be used sparingly—enter, make your change, return to Normal mode with `Esc`.

**Visual Mode** (entered via `v`, `V`, `Ctrl-v`): Select text regions. Similar to mouse highlighting in VSCode, but keyboard-driven. Movements extend the selection.

**Command-Line Mode** (entered via `:`): Execute ex commands. Save files (`:w`), quit (`:q`), search and replace (`:s/old/new/g`), or run any Neovim command.

### Why Modes Matter

The modal approach optimizes for editing time versus typing time. Consider:

- Programming involves more editing (rearranging, deleting, copying) than initial typing
- Navigation consumes significant development time
- Keeping hands on the home row eliminates mouse and arrow key movement

In Normal mode, `dd` deletes a line, `yy` copies it, `p` pastes it. These operations require no modifier keys, enabling rapid execution through muscle memory.

### The Verb-Noun Grammar

Neovim commands follow a composable grammar:

```
[count] operator [count] motion
```

**Operators** (verbs): `d` (delete), `c` (change), `y` (yank/copy), `>` (indent)

**Motions** (nouns): `w` (word), `}` (paragraph), `t"` (until quote), `iw` (inner word)

Examples:
- `d2w` - Delete two words
- `c}` - Change until end of paragraph
- `y4j` - Yank (copy) four lines down
- `>iB` - Indent inner block (code between braces)

This composability means learning operators and motions independently, then combining them. Ten operators × ten motions = 100 commands from 20 concepts.

### Practical Modal Workflow

Consider editing a Go function in your climb-tracker project:

```go
func (s *WorkoutService) StartWorkout(locationID uint) (*models.Workout, error) {
    workout := &models.Workout{
        LocationID: locationID,
        StartTime:  time.Now(),
    }
    return workout, s.db.Create(workout).Error
}
```

**VSCode approach**: Mouse to line, triple-click to select, type replacement.

**Neovim approach**: Place cursor anywhere on line, `ci{` (change inner braces), type new content, `Esc`. Three keystrokes versus mouse movement and clicking.

### Navigating in Normal Mode

Movement commands replace arrow keys:

- `h, j, k, l` - Left, down, up, right (arrow keys work, but home row is faster)
- `w, b` - Forward/backward by word
- `0, $` - Line start, line end
- `gg, G` - File start, file end
- `{, }` - Paragraph up, paragraph down
- `/pattern` - Search forward (your muscle memory from VSCode Ctrl+F)
- `n, N` - Next/previous search result

Your configuration includes relative line numbers disabled (`lua/config/options.lua:6`), making absolute jumps straightforward: `15G` jumps to line 15.

### Editing Efficiently

**Text Objects**: Commands that understand code structure:

- `ciw` - Change inner word (cursor anywhere in word)
- `ci"` - Change inside quotes
- `ci{` - Change inside braces
- `cit` - Change inside tag (HTML/XML)
- `da(` - Delete around parentheses (includes the parentheses)

**Dot Command**: `.` repeats the last change. Make a change once, then `.` applies it elsewhere. This is Neovim's macro system for simple repetitions.

**Combining Commands**: Normal mode commands chain naturally:
- `>}` indents to paragraph end
- `gUiw` uppercases inner word
- `dap` deletes around paragraph

### The Insert Mode Mindset

Insert mode should be transient. The workflow becomes:

1. Navigate in Normal mode (fast, keyboard-driven)
2. Enter Insert mode at the precise location
3. Type the minimal change
4. Return to Normal mode immediately

This differs from VSCode's continuous Insert mode. The context switch feels unnatural initially but becomes reflexive with practice.

### Your Configuration's Modal Enhancements

LazyVim adds modal-aware features:

- `<leader>` (Space) opens a which-key menu showing available commands in current context
- `gcc` in Normal mode comments the current line (your `git.lua` configuration)
- `gc` with a motion comments that region (e.g., `gcap` comments a paragraph)
- Visual mode selections work with all operators: select text, then `d`, `c`, or `y`

The auto-save on focus loss (`lua/config/autocmds.lua:17-22`) means leaving Insert mode and switching to your browser automatically saves—no explicit `:w` needed.

### Transitioning from VSCode

Key mental shifts:

1. **Stop holding keys**: In VSCode, hold Ctrl for shortcuts. In Neovim, tap single keys in Normal mode.

2. **Think in operations**: Instead of "select this text," think "change inside these braces."

3. **Embrace Escape**: Make `Esc` reflexive. Some users remap Caps Lock to Escape for easier access.

4. **Navigate before editing**: Position cursor precisely in Normal mode before entering Insert mode.

The learning curve is real, but modal editing's efficiency compounds over time. Your configuration provides modern conveniences (LSP, file trees) while preserving Neovim's modal power.

---


## Chapter 3: LazyVim: A Modern Foundation

### What LazyVim Provides

LazyVim is a Neovim configuration framework, not a fork or separate editor. It provides a curated set of plugins and sensible defaults that transform vanilla Neovim into a modern development environment.

Think of it as a sophisticated dotfiles repository with:

- Pre-configured plugin suite for common development needs
- Organized structure for custom configurations
- Lazy loading to maintain startup performance
- Opinionated defaults based on community best practices
- Extensibility through "extras" for specific languages and tools

Your `~/.config/nvim/init.lua` bootstraps LazyVim with a single line: `require("config.lazy")`. This loads the entire framework.

### The LazyVim Architecture

LazyVim organizes configuration into logical layers:

**Core Layer** (`lazy.nvim`): The plugin manager itself. Handles installation, updates, lazy loading, and dependency resolution.

**LazyVim Base**: Default plugins and configurations for file navigation (Telescope, Neo-tree), LSP support, syntax highlighting (Treesitter), and status lines.

**Extras**: Optional modules for specific languages (Go, TypeScript) or tools (debugging, testing). You've enabled several: `lang.go`, `lang.typescript`, `lang.tailwindcss`, `dap.core`.

**User Configurations**: Your customizations in `lua/config/` override LazyVim defaults. Your `options.lua` sets Go-specific tab handling, `autocmds.lua` enables auto-save, and `keymaps.lua` modifies Neo-tree behavior.

**User Plugins**: Your `lua/plugins/` directory contains custom plugin specifications. Each `.lua` file defines plugins or modifies LazyVim's defaults.

### The lazy.nvim Plugin Manager

Understanding lazy.nvim clarifies how your configuration works:

**Lazy Loading**: Plugins load only when needed. Your `sql.lua` loads vim-dadbod only when executing `:DBUI` commands. This keeps startup fast despite having many plugins.

**Declarative Specifications**: Each plugin file returns a Lua table describing plugins:

```lua
-- From your lua/plugins/octo.lua
return {
  "pwntester/octo.nvim",  -- GitHub repository
  dependencies = {         -- Plugins this depends on
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Octo",           -- Load when :Octo is executed
  config = function()     -- Configuration to run after loading
    require("octo").setup({ ... })
  end,
}
```

**Dependency Management**: lazy.nvim ensures dependencies load before dependents. Your octo.nvim depends on Telescope, so Telescope loads first.

### LazyVim Extras System

Extras provide pre-configured bundles for specific technologies. You've enabled:

**`lang.go`** (referenced in `lua/plugins/go.lua:17`): Includes gopls LSP configuration, Go debugging support, test runners, and gofmt integration. This single import provides complete Go development setup.

**`lang.typescript`** (`lua/plugins/typescript.lua:2`): Adds tsserver LSP for your Playwright tests, ESLint integration, and TypeScript-specific commands.

**`lang.tailwindcss`** (`lua/plugins/tailwind.lua:2`): Enables Tailwind CSS class completion and hover documentation for your HTMX templates.

**`dap.core`** (`lua/plugins/dap.lua:2`): Debug Adapter Protocol support for setting breakpoints and stepping through Go code.

View available extras with `:LazyExtras`. Enabling an extra is simple: `{ import = "lazyvim.plugins.extras.lang.go" }` in any plugin file.

### Directory Structure Explained

Your `~/.config/nvim/` follows LazyVim conventions:

```
~/.config/nvim/
├── init.lua                    # Entry point (bootstraps LazyVim)
├── lua/
│   ├── config/                 # Core configurations (loaded first)
│   │   ├── autocmds.lua       # Auto-commands (auto-save, etc.)
│   │   ├── keymaps.lua        # Key mappings (Neo-tree toggle, etc.)
│   │   ├── lazy.lua           # lazy.nvim bootstrap code
│   │   └── options.lua        # Editor options (tabs, line numbers)
│   └── plugins/               # Plugin specifications (loaded second)
│       ├── go.lua             # Go development plugins
│       ├── templ.lua          # templ template support
│       ├── tailwind.lua       # Tailwind CSS integration
│       ├── typescript.lua     # TypeScript/Playwright support
│       ├── docker.lua         # Dockerfile syntax
│       ├── sql.lua            # Database access
│       ├── git.lua            # Git enhancements
│       ├── make.lua           # Makefile support
│       ├── htmx.lua           # HTMX attribute support
│       ├── dap.lua            # Debugging
│       ├── playwright.lua     # Test runner
│       ├── octo.lua           # GitHub PR integration
│       └── ...                # Other plugins
├── lazyvim.json               # LazyVim state file
├── lazy-lock.json             # Plugin version lockfile
└── README.md, REFERENCE.md    # Documentation
```

**Load Order**: `init.lua` → `lua/config/lazy.lua` → `lua/config/*.lua` → LazyVim core → `lua/plugins/*.lua` → Extras

### Key LazyVim Features

**Which-Key Integration**: Press `<leader>` (Space) and wait. A popup shows available commands organized by category. This discoverability bridges the gap between VSCode's menu system and Neovim's keyboard-driven interface.

**Telescope Fuzzy Finding**: `<leader>ff` (find files) and `<leader>fg` (live grep) provide VSCode's Ctrl+P and Ctrl+Shift+F equivalents. Telescope is LazyVim's default file navigation.

**Neo-tree File Explorer**: `<leader>e` toggles a familiar sidebar file tree. Your `keymaps.lua:7-18` customizes this to focus Neo-tree if already open.

**LSP Zero Configuration**: LazyVim configures LSP clients automatically. Your `go.lua` imports the lang.go extra, which installs gopls and configures it for Go files. No manual LSP setup required.

**Treesitter Syntax**: LazyVim uses Treesitter for syntax highlighting instead of regex-based vim syntax files. This provides more accurate highlighting and enables syntax-aware operations.

### Customization Philosophy

LazyVim follows "convention over configuration" while remaining highly customizable:

**Defaults First**: LazyVim's defaults work for most users. Start with them before customizing.

**Override, Don't Replace**: Your `options.lua` sets Go tab preferences (lines 9-14) without disabling LazyVim's other option settings.

**Extend via Plugins**: Add functionality by creating new plugin files, not by modifying LazyVim core.

**Use Extras**: Before writing custom configurations, check if an Extra exists (`:LazyExtras`).

Your configuration exemplifies this: you've added project-specific plugins (templ, htmx, octo) while leveraging LazyVim extras for common languages (Go, TypeScript).

### Plugin Management Workflow

**Installing Plugins**: Create a file in `lua/plugins/` returning a plugin specification. On next Neovim start, lazy.nvim auto-installs it.

**Updating Plugins**: `:Lazy update` updates all plugins to their latest commits. The `lazy-lock.json` file tracks exact versions for reproducibility.

**Removing Plugins**: Delete the plugin specification file and run `:Lazy clean`. Lazy.nvim removes unused plugins.

**Viewing Status**: `:Lazy` opens the plugin manager UI showing installed plugins, their status, and available updates.

### Mason: LSP/Tool Installer

LazyVim includes Mason, a tool manager for LSP servers, formatters, and linters:

**Purpose**: Installs language servers without requiring system package managers. Your gopls, templ LSP, and sqlls install through Mason.

**Usage**: `:Mason` opens the installer UI. Search for tools, press `i` to install.

**Integration**: LazyVim automatically configures installed LSP servers. Install gopls via Mason, and Go files immediately get LSP support.

Your `go.lua` references this: importing `lang.go` extra ensures gopls installation through Mason.

### Configuration Pattern: Your go.lua

Let's examine your `lua/plugins/go.lua` as a LazyVim configuration example:

```lua
-- Lines 1-17: Comments explaining why this plugin exists
-- Why: Provides gopls LSP, gofmt, testing, struct tags
-- Critical for: Echo handlers, GORM models, services

return {
  -- Line 17: Import the LazyVim Go extras bundle
  { import = "lazyvim.plugins.extras.lang.go" },
}
```

This 18-line file enables comprehensive Go development. The brevity demonstrates LazyVim's power: importing an extra provides:

- gopls LSP server installation and configuration
- gofmt/goimports formatting on save
- Go test integration
- Debug adapter (Delve) configuration
- Go-specific keybindings

One line of code, dozens of features. This is LazyVim's value proposition.

### Your Configuration's Unique Aspects

Your setup demonstrates thoughtful LazyVim customization:

**Project-Specific Plugins**: templ LSP for Go templates, HTMX support for frontend attributes, vim-dadbod for PostgreSQL access. These address climb-tracker's specific stack.

**Minimal Extras**: You've enabled only needed extras (Go, TypeScript, Tailwind, DAP). This keeps the configuration lean.

**Documented Rationale**: Each plugin file explains why it exists (lines 1-17 in go.lua). This documentation-as-code approach aids maintenance.

**Auto-save Integration**: Your `autocmds.lua` auto-save on focus loss suits HTMX development's rapid browser testing.

LazyVim provides the foundation; your customizations tailor it to full-stack Go development with HTMX frontends.

---


## Chapter 4: The Plugin Ecosystem

### How Neovim Plugins Work

Neovim plugins are Lua or Vimscript programs that extend editor functionality. Unlike VSCode extensions, which run in sandboxed environments with restricted APIs, Neovim plugins have full access to the editor's internals.

The plugin architecture relies on:

**Autoload**: Code loads automatically when needed, typically when specific events trigger or commands execute.

**API Access**: Plugins interact with Neovim via `vim.api` (core API), `vim.fn` (Vimscript functions), and `vim.keymap` (key mappings).

**Event System**: Plugins hook into autocmds (automatic commands) that fire on events like "file opened" or "buffer saved."

Your plugin files in `lua/plugins/` define specifications that lazy.nvim uses to install and configure plugins.

### Plugin Categories in Your Setup

Your configuration includes plugins across several categories:

**Language Support**: LSP clients, syntax highlighting, formatters
- `go.lua`: gopls LSP for Go
- `templ.lua`: templ LSP and Treesitter for Go templates
- `typescript.lua`: tsserver for Playwright tests
- `tailwind.lua`: Tailwind CSS language server

**Infrastructure Tools**: Development environment integration
- `docker.lua`: Dockerfile and compose file syntax
- `sql.lua`: PostgreSQL database access
- `make.lua`: Makefile syntax highlighting

**Workflow Enhancement**: Git, GitHub, testing
- `git.lua`: Enhanced git integration with inline blame
- `octo.lua`: GitHub PR management from editor
- `playwright.lua`: Test runner integration

**Quality of Life**: Developer experience improvements
- `htmx.lua`: HTMX attribute awareness
- `dap.lua`: Debugging with breakpoints and stepping

### Anatomy of a Plugin Specification

Your `octo.lua` demonstrates plugin specification structure:

```lua
return {
  "pwntester/octo.nvim",        -- Plugin repository (GitHub)
  dependencies = {              -- Required plugins
    "nvim-lua/plenary.nvim",   -- Lua utility functions
    "nvim-telescope/telescope.nvim",  -- Fuzzy finder
    "nvim-tree/nvim-web-devicons",    -- File icons
  },
  cmd = "Octo",                 -- Load when :Octo command runs
  config = function()           -- Configuration after loading
    require("octo").setup({
      default_remote = { "origin" },
      timeout = 5000,
      -- ... additional settings
    })
  end,
}
```

**Repository**: Plugins typically live on GitHub as `username/repo`. lazy.nvim clones them to `~/.local/share/nvim/lazy/`.

**Dependencies**: Other plugins this one requires. lazy.nvim installs and loads dependencies first.

**Lazy Loading Triggers**: `cmd` (command), `ft` (filetype), `keys` (keybinding), `event` (autocmd event). This defers loading until needed.

**Configuration Function**: Runs after the plugin loads, calling its `setup()` function with options.

### The Treesitter Plugin

Treesitter deserves special attention. It parses code into syntax trees, enabling:

**Accurate Highlighting**: Unlike regex-based syntax files, Treesitter understands language grammar. Your Go code gets semantically correct highlighting.

**Syntax-Aware Editing**: Text objects like "inner function" or "outer class" work because Treesitter knows code structure.

**Incremental Parsing**: Edits only reparse changed sections, maintaining performance in large files.

Your `templ.lua` adds Treesitter support:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "templ" },  -- Auto-install templ parser
  },
}
```

LazyVim includes Treesitter by default. Your plugins extend it by adding language parsers.

### The LSP Client Plugin

Neovim's built-in LSP client (`vim.lsp`) is technically not a plugin but built-in functionality. However, `nvim-lspconfig` (included in LazyVim) provides pre-configured server setups.

Your `templ.lua` configures the templ LSP:

```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      templ = {},  -- Use default templ LSP configuration
    },
  },
}
```

This tells nvim-lspconfig to start the templ language server when editing `.templ` files. The LSP provides completion, diagnostics, and go-to-definition.

### Telescope: Fuzzy Finding

Telescope provides VSCode's Ctrl+P functionality. LazyVim includes it by default with keybindings:

- `<leader>ff`: Find files (fuzzy search filenames)
- `<leader>fg`: Live grep (search file contents)
- `<leader>fb`: Browse buffers
- `<leader>fr`: Recent files

Telescope works by:

1. Running a "finder" (file list, grep results, etc.)
2. Displaying results in a floating window
3. Filtering results as you type
4. Previewing selections before opening

Your octo.nvim integrates with Telescope for PR selection and issue browsing.

### Neo-tree: File Explorer

Neo-tree provides a familiar sidebar file tree. Your `keymaps.lua` customizes its behavior:

```lua
vim.keymap.set("n", "<leader>e", function()
  local neotree_bufnr = vim.fn.bufnr("neo-tree")
  local neotree_window = vim.fn.win_findbuf(neotree_bufnr)
  
  if #neotree_window == 1 and vim.fn.winnr() ~= neotree_window then
    vim.fn.win_gotoid(neotree_window[1])  -- Focus if open
  else
    vim.cmd("Neotree toggle")  -- Toggle otherwise
  end
end, { desc = "Toggle or focus Neo-tree" })
```

This makes `<leader>e` toggle Neo-tree when closed, or focus it when open. Without this customization, pressing `<leader>e` with Neo-tree open would close it.

### vim-dadbod: Database Access

Your `sql.lua` includes vim-dadbod, a database interaction plugin:

```lua
{
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql" } },
  },
  cmd = { "DBUI", "DBUIToggle" },
}
```

**Purpose**: Query your PostgreSQL database (localhost:5433) directly from Neovim. Useful for verifying data after running climb-tracker's API endpoints.

**Usage**: `:DBUIToggle` opens a sidebar. Navigate tables, press `o` to expand, `<leader>S` to execute queries.

**Integration**: SQL completion provides table and column names while writing queries.

This plugin demonstrates Neovim's extensibility: full database access within the editor.

### The Git Plugin Suite

Your `git.lua` enhances git functionality:

```lua
{
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,      -- Show git blame inline
    current_line_blame_opts = {
      delay = 500,  -- Wait 500ms before showing
    },
  },
}
```

**Gitsigns**: Shows git diff signs in the gutter (added/modified/deleted lines). Your configuration adds inline blame, showing commit info for the current line.

**Lazygit Integration**: LazyVim includes lazygit (TUI git client). `<leader>gg` opens it in a floating terminal.

Together, these provide comprehensive git integration: inline diffs, blame annotations, and full git operations through lazygit.

### Plugin Discovery and Installation

Finding plugins:

**GitHub Search**: Most Neovim plugins live on GitHub. Search "neovim [feature]" to find plugins.

**Awesome Neovim**: A curated list at github.com/rockerBOO/awesome-neovim categorizes plugins.

**LazyVim Extras**: `:LazyExtras` shows pre-configured plugin bundles for common needs.

**Community Recommendations**: Neovim subreddit and Discord server discuss popular plugins.

Installing plugins:

1. Create a file in `lua/plugins/` (e.g., `new-plugin.lua`)
2. Return a plugin specification table
3. Restart Neovim or run `:Lazy reload`
4. lazy.nvim auto-installs the plugin

### Plugin Maintenance

**Updating**: `:Lazy update` updates all plugins to latest versions. The `lazy-lock.json` file tracks installed versions for reproducibility.

**Cleaning**: Remove a plugin specification file, then `:Lazy clean` removes the plugin.

**Troubleshooting**: `:Lazy` shows plugin status. Red indicators mean load failures. Check `:Lazy log` for error messages.

**Health Checks**: `:checkhealth` runs diagnostics for installed plugins, LSP servers, and Neovim itself.

### Performance Considerations

Lazy loading prevents startup slowdown:

**Unused Plugins Don't Load**: Your dap.lua doesn't load until you set a breakpoint. Your sql.lua doesn't load until you run `:DBUI`.

**Filetype-Specific Loading**: LSP servers load only for relevant files. gopls loads for `.go` files, not for TypeScript files.

**Startup Time**: `:Lazy profile` shows which plugins load at startup and their timing. Well-configured LazyVim starts in 20-50ms.

Your configuration demonstrates good lazy loading: most plugins have `cmd`, `ft`, or `event` triggers deferring their load.

### The Plugin Ecosystem vs. VSCode Extensions

Key differences:

**Open Access**: Neovim plugins access all editor functionality. VSCode extensions use restricted APIs.

**Language Agnostic**: LSP servers work identically in Neovim and VSCode. The protocol standardizes editor-server communication.

**Configuration**: Neovim plugins configure via Lua code. VSCode extensions use JSON settings.

**Distribution**: No centralized marketplace. Plugins distribute via GitHub, installed by plugin managers.

**Security**: Plugins run with full system access. Trust is important—review code before installation.

Your configuration includes well-established plugins from trusted authors: pwntester (octo.nvim), lewis6991 (gitsigns), kristijanhusak (dadbod-ui).

---


## Chapter 5: Language Server Protocol (LSP)

### What LSP Solves

Before LSP, every editor implemented language intelligence independently. VSCode had TypeScript support, IntelliJ had Java support, and Vim had ctags. This created:

- Duplicated effort: Each editor reimplemented parsing and analysis
- Inconsistent quality: Some editor-language combinations worked well, others poorly
- Maintenance burden: Language changes required updating every editor

Microsoft introduced the Language Server Protocol in 2016 to solve this. LSP standardizes communication between editors (clients) and language analysis tools (servers).

### The LSP Architecture

LSP follows a client-server model:

**Language Server**: A separate process that understands a specific language. gopls for Go, tsserver for TypeScript, templ for templ templates. These run independently of Neovim.

**LSP Client**: Built into Neovim (`vim.lsp`). Communicates with servers via JSON-RPC over stdin/stdout.

**Protocol**: Standardized messages for capabilities like:
- Completion requests: "What can I type at this position?"
- Definition requests: "Where is this function defined?"
- Diagnostic reports: "This code has an error"
- Formatting requests: "Format this file"

This separation means gopls provides identical functionality in Neovim, VSCode, and any other LSP-compatible editor.

### LSP Capabilities in Your Setup

Your configuration includes several language servers:

**gopls** (Go): Installed via the `lang.go` extra. Provides:
- Code completion for Go packages, functions, types
- Go-to-definition for functions and variables
- Error detection (type errors, unused imports)
- Formatting via gofmt/goimports
- Hover documentation
- Signature help (function parameters while typing)

**templ** (Go Templates): Configured in `templ.lua:9-17`. Provides:
- Type checking for data passed to templates
- Completion for Go variables in templates
- Syntax validation

**tailwindcss-language-server** (CSS): From `lang.tailwindcss` extra. Provides:
- Tailwind class completion
- Hover documentation for utility classes
- CSS variable support for your dark theme

**tsserver** (TypeScript): From `lang.typescript` extra. Provides:
- TypeScript completion in Playwright tests
- Type checking
- Import management

**sqlls** (SQL): Configured in `sql.lua:30-38`. Provides:
- SQL syntax validation
- Table and column completion

### How LSP Works in Practice

When you edit a Go file:

1. Neovim detects the `.go` filetype
2. nvim-lspconfig starts gopls (if not already running)
3. Neovim sends the file content to gopls
4. gopls analyzes the code, tracking your changes
5. As you type, gopls sends:
   - Completion suggestions
   - Error diagnostics
   - Hover information
6. When you request go-to-definition (`gd`), Neovim asks gopls for the location
7. gopls parses your code, finds the definition, returns the file and line

This happens asynchronously—typing never blocks waiting for LSP responses.

### LSP Keybindings in LazyVim

LazyVim configures standard LSP keybindings (documented in your REFERENCE.md):

**Navigation**:
- `gd` - Go to definition (jump to function/variable definition)
- `gD` - Go to declaration (Go interfaces, type declarations)
- `gr` - Show references (all usages of this symbol)
- `gi` - Go to implementation

**Information**:
- `K` - Hover documentation (shows function signature, types, docs)
- `<leader>cd` - Line diagnostics (errors/warnings on current line)

**Actions**:
- `<leader>ca` - Code actions (quick fixes, refactorings)
- `<leader>cr` - Rename symbol (rename across entire project)
- `<leader>cf` - Format file

**Navigation**:
- `]d` - Next diagnostic
- `[d` - Previous diagnostic

### Mason: LSP Server Management

Mason provides a UI for installing language servers without system package managers:

**Purpose**: Simplifies LSP server installation. Instead of `go install golang.org/x/tools/gopls@latest`, use `:Mason` → search "gopls" → press `i`.

**Integration**: LazyVim's `lang.*` extras ensure required servers install automatically. When you imported `lang.go`, Mason installed gopls.

**Manual Installation**: For servers not in extras (like sqlls), open `:Mason`, search, and install.

**Tool Management**: Mason also installs formatters (prettier), linters (eslint), and debuggers (delve).

Your configuration leverages this: the servers in your plugin files install via Mason automatically.

### LSP Configuration Pattern

Your `templ.lua` demonstrates LSP configuration:

```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      templ = {},  -- Use default configuration
    },
  },
}
```

This minimal configuration works because:

1. LazyVim includes nvim-lspconfig
2. nvim-lspconfig knows how to configure templ server
3. The empty table `{}` means "use defaults"
4. LazyVim auto-starts the server for `.templ` files

For custom configuration, provide options:

```lua
servers = {
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,  -- Warn about unused parameters
        },
      },
    },
  },
}
```

### Diagnostics and Error Handling

LSP servers continuously analyze code, sending diagnostics:

**Error Indicators**: Red underlines for errors, yellow for warnings. Your gutter shows sign markers.

**Viewing Diagnostics**: 
- Hover over underlined code for inline messages
- `<leader>cd` shows diagnostics in a floating window
- `<leader>xx` opens the diagnostics list (all errors in project)

**Navigation**: `]d` and `[d` jump between diagnostics, useful for fixing errors sequentially.

**Auto-Fix**: Some diagnostics have code actions. `<leader>ca` with cursor on error shows available fixes.

### Completion System

LSP powers code completion through nvim-cmp (included in LazyVim):

**Triggering**: Start typing. Completion menu appears automatically.

**Sources**: Completions come from:
- LSP servers (primary source)
- Current buffer (words already in file)
- Other buffers
- File paths
- Snippet engines

**Navigation**: `<Tab>` and `<Shift-Tab>` cycle through completions. `<CR>` (Enter) accepts.

**LSP Integration**: When typing `workout.`, gopls provides `workout.ID`, `workout.StartTime`, etc. This is LSP completion.

### Formatting

LSP handles code formatting:

**Auto-Format**: Your Go files format on save via gofmt (configured in `lang.go` extra).

**Manual Format**: `<leader>cf` formats the current buffer.

**Formatters**: LSP servers include formatters:
- gopls uses gofmt and goimports
- templ uses `templ fmt`
- prettier handles JavaScript (from `lang.typescript` extra)

The `conform.nvim` plugin (LazyVim default) manages formatter execution.

### Hover Information

`K` in Normal mode requests hover information:

**In Go Code**: Shows function signature, parameter types, return types, and documentation comments.

**In templ Templates**: Shows types of Go variables used in templates.

**In TypeScript**: Shows type annotations and JSDoc comments.

Press `K` twice to jump into the hover window for scrolling through long documentation.

### Workspace Management

LSP servers understand project scope:

**Project Root**: LSP servers detect project root by finding `go.mod`, `package.json`, or `.git`. All files under this root belong to the workspace.

**Multi-File Awareness**: Renaming a function with `<leader>cr` updates all files in the workspace, not just the current file.

**Import Management**: gopls adds missing imports and removes unused ones automatically.

Your climb-tracker project's `go.mod` defines the workspace root. gopls understands the entire project structure.

### LSP Troubleshooting

Common issues and solutions:

**LSP Not Starting**:
- Check `:LspInfo` to see attached servers
- Verify Mason installed the server: `:Mason`
- Check server binary exists in PATH
- Review logs: `:LspLog`

**Completion Not Working**:
- Ensure LSP server is running: `:LspInfo`
- Check completion source is enabled
- Verify you're in a recognized file type: `:set ft?`

**Slow Performance**:
- Check LSP server CPU usage
- Some servers (tsserver) struggle with large projects
- Consider disabling features in server settings

**Formatting Not Applied**:
- Check `:ConformInfo` to see active formatters
- Verify formatter is installed: `:Mason`
- Check format-on-save is enabled

### LSP vs. Traditional IDE

LSP provides IDE-quality intelligence:

**VSCode's Go Support**: Uses gopls identically to Neovim. Same completions, same diagnostics.

**Advantages**: 
- Language-agnostic: One protocol serves all editors
- Separation: Crashes in LSP server don't crash editor
- Flexibility: Mix different servers (gopls for Go, rust-analyzer for Rust)

**Performance**: LSP servers run as separate processes, utilizing multiple CPU cores. Your editor remains responsive while gopls analyzes code.

Your configuration demonstrates modern LSP integration: multiple servers (gopls, templ, tsserver, sqlls, tailwindcss) working together seamlessly.

---


## Chapter 6: Buffers, Windows, and Tabs

### The Buffer Model

Buffers represent in-memory file content. Unlike VSCode's tab-centric model, Neovim separates file content (buffers) from display (windows).

**What Buffers Are**: When you open a file, Neovim loads its contents into a buffer. The buffer exists independently of any window. Closing all windows showing a buffer doesn't delete the buffer—it remains in memory.

**Hidden Buffers**: Buffers can be "hidden," loaded in memory but not displayed. This enables fast switching: previously opened files remain in buffers, so reopening them is instantaneous.

**Buffer List**: `:ls` or `:buffers` shows all loaded buffers. LazyVim's `<leader>fb` opens Telescope's buffer picker for fuzzy searching this list.

### Buffers vs. VSCode Tabs

The mental model shift:

**VSCode**: One tab = one file. Closing a tab unloads the file. Tab order matters.

**Neovim**: One buffer = one file, but buffers exist independently of display. Many buffers can be loaded without visible windows.

Implications:

- Opening 20 files creates 20 buffers, but you might display only 3 in windows
- Switching buffers in a window (`<S-h>` and `<S-l>`) doesn't close the previous buffer
- The same buffer can appear in multiple windows simultaneously

### Window Management

Windows display buffer content. A window is a viewport into a buffer.

**Creating Windows**:
- `<leader>w-` - Split horizontally (creates window below)
- `<leader>w|` - Split vertically (creates window to the right)
- `:split filename` - Split and load file in new window
- `:vsplit filename` - Vertical split with file

**Navigating Windows**:
- `<C-h>` - Move to left window
- `<C-j>` - Move to window below  
- `<C-k>` - Move to window above
- `<C-l>` - Move to right window

These keybindings (in your REFERENCE.md) eliminate mouse usage. Muscle memory for `<C-hjkl>` becomes reflexive with practice.

**Resizing Windows**:
- `<C-Up>` - Increase height
- `<C-Down>` - Decrease height
- `<C-Left>` - Decrease width
- `<C-Right>` - Increase width

**Closing Windows**: `<leader>wd` closes the current window. If it's the last window showing a buffer, the buffer remains loaded (hidden).

### The Split Workflow

Effective use of splits:

**Reference + Implementation**: Split vertically to show an interface definition on the left and implementation on the right.

**Test + Code**: Split horizontally with tests above and implementation below. Edit both simultaneously.

**Multiple Files**: Work on a Go handler, its template, and the model simultaneously in three splits.

Example workflow editing climb-tracker:

1. Open handler: `nvim internal/handlers/api/workout.go`
2. Split for model: `<leader>w|` then `<leader>ff` to find `internal/models/workout.go`
3. Split for template: `<leader>w-` then `<leader>ff` to find `internal/templates/components/workout.templ`
4. Navigate between splits with `<C-hjkl>`

### Buffer Navigation

LazyVim provides buffer navigation keybindings:

**Buffer Switching**:
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<leader><leader>` - Toggle to last buffer (quick back-and-forth)
- `<leader>fb` - Fuzzy find buffer

**Buffer Management**:
- `<leader>bd` - Delete current buffer (close file)
- `<leader>bD` - Delete all buffers except current
- `<leader>bp` - Pin buffer (prevent accidental close)

**Direct Access**: `:buffer N` switches to buffer number N (from `:ls` list).

### Tabs in Neovim

Tabs in Neovim aren't file tabs—they're workspace layouts.

**What Tabs Are**: A tab holds a window arrangement. Create a tab, split windows as desired, and switch between tabs to switch entire layouts.

**Use Case**: One tab for coding (splits with handler, model, template), another tab for documentation (single window with README), another for debugging (splits with code and terminal).

**Tab Commands**:
- `:tabnew` - Create new tab
- `gt` - Next tab
- `gT` - Previous tab
- `:tabclose` - Close current tab

**Practical Usage**: Most users rarely use tabs, preferring buffer switching and window splits. Your configuration doesn't define tab keybindings, suggesting this usage pattern.

### The Quickfix and Location Lists

These specialized buffers display structured results:

**Quickfix List**: Editor-global list of locations (file + line + column). Used for:
- Grep search results
- Compiler errors
- LSP diagnostics

**Location List**: Window-local version of quickfix. Each window has its own location list.

**Usage**:
- `<leader>xx` - Toggle diagnostics in quickfix
- `]q` - Next quickfix item
- `[q` - Previous quickfix item

Example workflow: `<leader>fg` to grep for "WorkoutService", then `]q` and `[q` to navigate results. Press Enter on a result to jump to that file and line.

### Practical Window Workflow

Consider debugging a bug in climb-tracker's workout creation:

**Initial State**: Single window with `internal/handlers/api/workout.go`

**Add Context**: `<leader>w|` splits vertically. `<leader>ff` → search "workout.go" → select `internal/models/workout.go`. Now see handler and model side-by-side.

**Add Database View**: `<leader>w-` splits the right window horizontally. `:DBUIToggle` opens database UI. Check current database state.

**Navigate**: `<C-h>` to handler code. Edit. `<C-l>` to model. `<C-j>` to database view.

**Cleanup**: `<leader>wd` closes database view. `<leader>wd` again closes model. Back to single window.

### Buffer Lifecycle

Understanding buffer states:

**Loaded**: Buffer exists in memory, may or may not be displayed.

**Hidden**: Buffer is loaded but not displayed in any window.

**Listed**: Buffer appears in `:ls`. Most file buffers are listed.

**Unlisted**: Buffer exists but doesn't appear in `:ls`. Terminal buffers and plugin buffers are often unlisted.

**Deleted**: Buffer removed from memory. `:bdelete N` or `<leader>bd`.

The distinction matters: closing a window hides the buffer; deleting a buffer removes it from memory.

### Your Configuration's Window Enhancements

LazyVim includes sensible defaults:

**Auto-Resize**: When you create or close splits, remaining windows auto-resize to reasonable proportions.

**Smart Split Directions**: `<leader>w-` creates horizontal splits below, `<leader>w|` creates vertical splits to the right (not above or left).

**Window Picker**: When many windows are open, window-switching plugins highlight windows with letters for quick jumping.

Your Neo-tree configuration (`keymaps.lua:7-18`) demonstrates window awareness: checking if Neo-tree window exists before toggling.

### Bufferline Plugin

LazyVim includes bufferline, which displays a tab-like bar at the top showing open buffers.

**Visual Feedback**: See all loaded buffers at a glance, similar to VSCode's tab bar.

**Interaction**: Click buffers to switch (mouse support), or use `<S-h>` and `<S-l>` to navigate.

**Indicators**: Shows modified status, LSP diagnostics, and file icons.

This provides a familiar visual metaphor while maintaining Neovim's buffer model underneath.

### Closing Buffers vs. Closing Windows

Common confusion point:

**`:q`** - Quit window (closes the window, buffer remains loaded)

**`:bd`** - Delete buffer (removes buffer, closes all windows showing it)

**`<leader>wd`** - Close current window (LazyVim keybinding for `:q`)

**`<leader>bd`** - Delete buffer (LazyVim keybinding for `:bd`)

When a buffer has unsaved changes, both commands prompt for confirmation.

### Multiple Windows, Same Buffer

You can display the same buffer in multiple windows:

1. Open a file
2. `<leader>w-` to split
3. In the new window, switch to the same buffer

Both windows show the same content. Edits in one window immediately appear in the other. Useful for editing top and bottom of a long file simultaneously.

### Terminal Buffers

Terminal emulators (covered in Chapter 8) create special buffers:

- Listed but have special handling
- Can't be modified like normal buffers
- Switching away hides them
- Closing the window doesn't terminate the terminal process

Your configuration's auto-save (`autocmds.lua:17-22`) intelligently skips terminal buffers when saving all buffers on focus loss.

### Practical Recommendations

**Start Simple**: Use single window with buffer switching (`<S-h>`, `<S-l>`, `<leader>fb`).

**Add Splits for Reference**: Split when you need to reference one file while editing another.

**Use Quickfix for Navigation**: Grep results, LSP diagnostics, and errors work better in quickfix than opening many buffers.

**Leverage Hidden Buffers**: Don't worry about closing buffers. Hidden buffers consume minimal memory and enable instant switching.

**Master Window Navigation**: `<C-hjkl>` becomes reflexive with practice, faster than mouse movement.

Your configuration provides the tools. The buffer-window-tab model rewards understanding with flexibility VSCode's tab model can't match.

---


## Chapter 7: The Quickfix List

### What the Quickfix List Is

The quickfix list is a structured buffer containing file locations and associated text. Originally designed for compiler errors (quick fixes), it now serves as a universal location list for search results, diagnostics, and any file-position data.

Each quickfix entry contains:
- Filename
- Line number
- Column number (optional)
- Message text

### Why Quickfix Exists

Traditional editors display search results in a separate pane, requiring manual navigation to each result. Neovim's quickfix integrates results into the editor's navigation system.

**Advantages**:
- Navigate results with consistent keybindings (`]q`, `[q`)
- Preview results before jumping
- Build custom workflows by populating quickfix from various sources
- Stack quickfix lists (keep history of searches/compilations)

### Common Quickfix Sources

Your LazyVim configuration populates quickfix from several sources:

**Grep Results**: `<leader>fg` (live grep via Telescope) can send results to quickfix. After searching, press `<C-q>` in Telescope to send results to quickfix.

**LSP Diagnostics**: `<leader>xx` toggles a quickfix-style list of all errors and warnings in your project. Navigate with `]q` and `[q`.

**Compiler Output**: Running `:make` (which your Makefile support enables) populates quickfix with build errors.

**Location References**: `gr` (go to references) shows all usages of a symbol. These populate a location list (similar to quickfix but window-local).

### Navigating the Quickfix List

LazyVim provides standard navigation keybindings (documented in your REFERENCE.md):

**Opening**:
- `<leader>xq` - Toggle quickfix list
- `:copen` - Open quickfix window

**Navigation**:
- `]q` - Next quickfix item (jumps to file/line)
- `[q` - Previous quickfix item
- `<CR>` - Jump to item under cursor (when in quickfix window)

**Closing**:
- `:cclose` - Close quickfix window
- `<leader>xq` - Toggle (closes if open)

### Practical Quickfix Workflow

Example: Finding all usages of `WorkoutService` in climb-tracker:

1. **Search**: `<leader>fg` → type "WorkoutService"
2. **Populate Quickfix**: Press `<C-q>` in Telescope to send all results to quickfix
3. **Navigate**: `]q` jumps to first result, opening the file
4. **Review Context**: Read surrounding code
5. **Continue**: `]q` to next occurrence, review, repeat
6. **Jump Back**: `<C-o>` returns to previous location (jump list, not quickfix)

This workflow eliminates manual result clicking. Navigate purely with keyboard.

### The Location List

Location lists are window-local versions of quickfix:

**Difference**: Quickfix is editor-global (one list for entire session). Location lists are per-window (each window can have its own list).

**Usage**: LSP's "go to references" (`gr`) uses location lists. The results appear in the current window's location list, not the global quickfix.

**Navigation**:
- `]d` - Next location (LSP diagnostic navigation uses this)
- `[d` - Previous location

**Opening**: `:lopen` opens the location list window.

Most users interact primarily with quickfix, using location lists implicitly through LSP commands.

### Quickfix Window Interaction

The quickfix window behaves like a special buffer:

**Display**: Shows file:line:column + message text. Each line represents one location.

**Navigation**: `j` and `k` move through entries. `<CR>` jumps to the selected entry's file and line.

**Filtering**: Edit the quickfix buffer to remove unwanted entries. Deleting lines removes those results.

**Refreshing**: Some plugins auto-update quickfix when source data changes (e.g., LSP diagnostics refresh as you fix errors).

### Quickfix Stack

Neovim maintains a quickfix history:

**Multiple Lists**: Each search or compilation creates a new quickfix list, pushing the previous list onto a stack.

**Navigation**:
- `:colder` - Load older quickfix list
- `:cnewer` - Load newer quickfix list

**Use Case**: Search for "Workout", review results, search for "Climb", then `:colder` to return to "Workout" results.

This stack enables non-linear workflows: pursue tangents without losing original search results.

### Building Custom Quickfix Lists

Advanced usage: populate quickfix programmatically.

**From Shell Commands**: `:cexpr system('grep -rn "pattern" .')` populates quickfix from grep output.

**From Scripts**: Lua code can build quickfix lists:

```lua
vim.fn.setqflist({
  {filename = "file1.go", lnum = 10, text = "TODO: fix this"},
  {filename = "file2.go", lnum = 25, text = "TODO: refactor"},
})
vim.cmd('copen')
```

**From LSP**: Plugins can query LSP for symbols, diagnostics, or references and populate quickfix.

Your configuration doesn't include custom quickfix builders, but the capability exists for advanced workflows.

### Integration with Other Tools

Quickfix integrates with your development toolchain:

**Make Integration**: Your `make.lua` ensures Makefiles syntax highlighting. Running `:make build` in climb-tracker executes `make build` and populates quickfix with any compilation errors.

**Grep Integration**: While you'll typically use Telescope's live grep (`<leader>fg`), `:grep pattern` populates quickfix directly.

**Git Integration**: Some git plugins populate quickfix with merge conflicts or changed files.

### Quickfix vs. Telescope

LazyVim provides both quickfix and Telescope for location-based navigation. When to use each:

**Telescope** (default preference):
- Interactive fuzzy filtering
- Live preview
- Better for finding files or content when you're unsure of exact names
- Your `<leader>ff` and `<leader>fg` use Telescope

**Quickfix** (when needed):
- Persistent results (survive closing the search)
- Programmatic population (from Make, grep, custom scripts)
- Stack history (`:colder` and `:cnewer`)
- Integration with traditional Unix tools

Workflow: Use Telescope for initial search, send results to quickfix (`<C-q>`) if you need persistence or complex navigation.

### LSP Diagnostics in Quickfix

Your LSP configuration uses quickfix for diagnostics:

**Triggering**: `<leader>xx` opens the diagnostics list (errors and warnings across all files).

**Content**: Each entry shows filename, line, diagnostic message, and severity (error/warning/info).

**Workflow**:
1. `<leader>xx` to see all errors
2. `]q` to jump to first error
3. Fix the error
4. `]q` to next error
5. Repeat until all errors fixed

As you fix errors, LSP updates diagnostics in real-time. Some configurations auto-refresh the quickfix list.

### Quickfix Plugins

While LazyVim's default quickfix works well, plugins enhance it:

**nvim-bqf**: Better quickfix window with preview, fuzzy filtering in quickfix, and enhanced navigation.

**trouble.nvim**: LazyVim includes this for a modern diagnostics/quickfix UI. Your `<leader>xx` likely uses Trouble instead of raw quickfix.

**vim-qf**: Additional quickfix features like toggling, wrapping navigation, and filtering.

Your configuration uses LazyVim's defaults. The `<leader>xx` keybinding opens Trouble, which provides a more visual quickfix experience.

### Practical Recommendations

**Learn Basic Navigation**: Master `]q`, `[q`, and `:copen`. These work consistently across quickfix sources.

**Use Telescope First**: Telescope's live preview and fuzzy finding usually work better than raw quickfix.

**Send to Quickfix for Persistence**: When Telescope search results need to persist while you work, press `<C-q>` to transfer them.

**Embrace Diagnostics Navigation**: `<leader>xx` then `]q`/`[q` is faster than clicking individual errors.

**Explore Trouble**: LazyVim's Trouble plugin enhances diagnostics display. Experiment with it via `<leader>xx`.

The quickfix list exemplifies Neovim's philosophy: simple, composable tools that integrate naturally into keyboard-driven workflows. Your configuration leverages this through LSP diagnostics and Telescope integration.

---


## Chapter 8: Terminal Emulator

### Neovim's Built-in Terminal

Neovim includes a full terminal emulator accessible from within the editor. Unlike VSCode's integrated terminal (a separate pane), Neovim terminals are buffers that can appear in any window.

The terminal emulator executes actual shell processes:

- Full shell capabilities (bash, zsh, fish)
- Runs interactive programs (psql, lazygit, Node REPL)
- Supports colors and formatting
- Integrates with Neovim's buffer/window system

### Opening Terminals

LazyVim provides convenient terminal keybindings (from your REFERENCE.md):

**Floating Terminal**: `<leader>ft` - Opens a terminal in a floating window overlaying your editor.

**Bottom Terminal**: `<leader>fT` - Opens a terminal at the bottom of the screen, similar to VSCode's integrated terminal.

**Manual Creation**: 
- `:terminal` - Opens terminal in current window
- `:split | terminal` - Opens terminal in horizontal split
- `:vsplit | terminal` - Opens terminal in vertical split

### Terminal Modes

Terminals introduce an additional mode: Terminal mode.

**Terminal Mode**: Active when a terminal buffer has focus. Keystrokes send to the shell, not Neovim.

**Exiting Terminal Mode**: `<C-\><C-n>` enters Normal mode. Now Neovim commands work (hjkl navigation, window switching, etc.).

**Re-entering Terminal Mode**: `i` or `a` in Normal mode returns to Terminal mode, resuming shell interaction.

**Quick Toggle**: LazyVim's `<C-/>` toggles terminal visibility (documented in REFERENCE.md line 77).

### Terminal Workflow

Typical usage pattern:

1. **Open Terminal**: `<leader>ft` for floating terminal
2. **Run Command**: Type shell command (e.g., `make build`)
3. **Review Output**: Scroll through output if needed
4. **Return to Editing**: `<C-/>` hides terminal (or `<Esc><Esc>` with LazyVim's config)
5. **Reopen Terminal**: `<C-/>` shows same terminal (process still running)

The terminal persists: closing the window doesn't terminate the shell. Hidden terminal buffers remain active.

### Terminal vs. External Terminal

Why use Neovim's terminal instead of a separate terminal app?

**Context Switching**: Stay in Neovim. No Alt-Tab to external terminal.

**Shared Environment**: Terminal sees your current working directory automatically.

**Copy/Paste Integration**: Yank text from code, paste into terminal (and vice versa) using Neovim's registers.

**Window Integration**: Terminal is a window/buffer, so split management works identically to file editing.

**Automation**: Scripts can send commands to terminals programmatically.

### Practical Terminal Use Cases

Your climb-tracker workflow benefits from integrated terminals:

**Running Development Server**: `<leader>ft` → `./scripts/start-dev.sh`. Terminal shows logs. Edit code, save, server hot-reloads. `<C-/>` hides terminal without stopping server.

**Database Queries**: `<leader>ft` → `psql -h localhost -p 5433 -U climb_tracker_user climb_tracker`. Run queries, review results, copy output to code comments.

**Git Commands**: While lazygit (`<leader>gg`) handles most git operations, terminal access enables custom git commands.

**Running Tests**: `<leader>ft` → `npm run test:e2e`. Watch Playwright tests execute, review output, switch back to code.

**Make Commands**: `<leader>ft` → `make build-templ` or `make build-css`. See build output immediately.

### Terminal Buffer Management

Terminals are buffers with special properties:

**Listing**: Terminal buffers appear in `:ls` with names like `term://.../zsh`.

**Switching**: Navigate to terminal buffers like any buffer (`<S-h>`, `<S-l>`, `<leader>fb`).

**Closing**: `:bd` on a terminal buffer terminates the shell process. LazyVim's terminal management typically hides rather than closes.

**Auto-Save**: Your `autocmds.lua` auto-save configuration (`silent! wa`) safely handles terminal buffers (can't save them, so the `silent!` suppresses errors).

### Terminal Job Control

Terminals run shell processes as Neovim jobs:

**Background Processes**: Start a long-running command, then `<C-\><C-n>` to return to Normal mode. The process continues in background.

**Process Termination**: Closing terminal buffer (`:bd`) terminates the process. Use `exit` in the shell to terminate gracefully.

**Multiple Terminals**: Open several terminals for different tasks (one for server, one for tests, one for database).

### LazyVim's Terminal Enhancements

LazyVim improves default terminal experience:

**Persistent Terminals**: Opened terminals persist across sessions. Close Neovim, reopen, and `<C-/>` shows the previous terminal.

**Terminal Selector**: If multiple terminals exist, terminal keybindings show a selector to choose which terminal to toggle.

**Smart Sizing**: Floating terminals resize appropriately. Bottom terminals occupy ~30% of screen height.

**ESC Mapping**: LazyVim maps `<Esc><Esc>` to exit Terminal mode (easier than `<C-\><C-n>`).

### Terminal Navigation

When in Normal mode in a terminal buffer:

**Scrolling**: `j`, `k`, `<C-d>`, `<C-u>` scroll through terminal output (command history).

**Searching**: `/` searches terminal output. Useful for finding specific log messages.

**Copying**: Yank terminal output with standard Neovim commands (`yy`, `y$`, etc.). Paste into files or other terminals.

**Window Commands**: `<C-hjkl>` switches to other windows. Terminal remains running.

### Integration with lazygit

Your configuration includes lazygit integration (`<leader>gg`). LazyVim opens lazygit in a terminal:

1. `<leader>gg` opens a floating terminal
2. Launches lazygit in that terminal
3. Full lazygit functionality within Neovim
4. Closing lazygit closes the terminal

This pattern—launching TUI programs in Neovim terminals—extends to other tools (htop, psql, etc.).

### Terminal-Specific Configurations

Your configuration's terminal handling:

**Auto-save Skip**: The `autocmds.lua` auto-save (`silent! wa`) doesn't attempt saving terminal buffers (would fail).

**Keymaps**: LazyVim includes terminal-specific keymaps that only activate in terminal buffers.

**Filetype Detection**: Terminal buffers have filetype `terminal`, enabling terminal-specific autocmds.

### Running REPLs

Interactive programming REPLs work in terminals:

**Node.js**: `<leader>ft` → `node`. Write JavaScript, test expressions, debug.

**Go Playground**: `<leader>ft` → `go run .`. Quick Go experimentation.

**psql**: `<leader>ft` → `psql [connection string]`. Interactive PostgreSQL access (alternative to vim-dadbod).

**Python**: `<leader>ft` → `python3`. Script testing and exploration.

Exit REPLs with their standard exit commands (Ctrl+D, `.exit`, `\q`), and the terminal remains open in your shell.

### Terminal vs. vim-dadbod

Your configuration includes both terminal access and vim-dadbod (`sql.lua`). When to use each:

**Terminal psql**:
- Complex queries spanning multiple lines
- Transaction testing (BEGIN, COMMIT, ROLLBACK)
- PostgreSQL-specific commands (\d, \dt)
- Copy/paste large SQL scripts

**vim-dadbod** (`:DBUIToggle`):
- Visual table browsing
- Quick single queries
- Schema exploration
- Integrated completion

Both have value. Terminal provides raw PostgreSQL access; vim-dadbod provides structure.

### Debugging with Terminals

When debugging climb-tracker:

**Server Logs**: `<leader>ft` → `./scripts/start-dev.sh`. Logs appear in real-time. Edit code in another window while watching logs in terminal.

**Error Investigation**: Copy error messages from terminal, paste into browser or code comments.

**Multi-Stage Debugging**: One terminal for server, another for database queries, code in main windows. All visible simultaneously in splits.

### Terminal Performance

Terminals handle large output efficiently:

**Scrollback**: Terminals buffer thousands of lines. Scroll back to review earlier output.

**Output Streaming**: Long-running commands (compilation, tests) stream output in real-time.

**Resource Usage**: Terminal buffers consume memory for scrollback but remain performant.

If a terminal accumulates excessive output, close and reopen: `<C-\><C-n>` → `:bd!` → `<leader>ft`.

### Advanced Terminal Usage

Power users extend terminal capabilities:

**Sending Text to Terminals**: Plugins can send code selections to terminal REPLs for execution.

**Terminal Multiplexing**: Run tmux or screen inside Neovim terminals for nested session management (though usually unnecessary).

**Automated Commands**: Scripts can populate terminal buffers with command output programmatically.

Your configuration doesn't include these advanced features, but the foundation exists.

### Practical Recommendations

**Use Floating Terminals for Quick Commands**: `<leader>ft` for short-lived commands (Make, git, ls).

**Use Bottom Terminals for Long-Running Processes**: `<leader>fT` for development servers or test watchers.

**Leverage Terminal Persistence**: Start your development server once, hide the terminal, work for hours, occasionally `<C-/>` to check logs.

**Combine with Splits**: Vertical split with code on left, terminal on right. Edit code, glance at terminal output.

**Master Terminal Mode Exit**: `<Esc><Esc>` (LazyVim) or `<C-\><C-n>` (standard) must become reflexive.

The terminal emulator exemplifies Neovim's integration philosophy: bringing external tools into the editor's unified interface. Your climb-tracker workflow leverages this for development servers, database access, and build commands—all without leaving Neovim.

---


## Chapter 9: File Navigation

### Navigation Philosophy

Neovim offers multiple file navigation paradigms, each optimized for different scenarios. Unlike VSCode's primary reliance on the sidebar file tree, Neovim emphasizes keyboard-driven, context-aware navigation.

The navigation tools in your LazyVim configuration:

- **Telescope**: Fuzzy finding for files and content
- **Neo-tree**: Visual file tree browser
- **LSP Navigation**: Jump to definitions, references, implementations
- **Marks and Jump Lists**: Traditional Vim navigation
- **Buffer Navigation**: Switch between recently opened files

### Telescope: Fuzzy Finding

Telescope provides Neovim's primary file navigation interface.

**Find Files** (`<leader>ff`): Fuzzy search all files in project. Type partial filename, Telescope matches:

- `wk` matches `workout.go`
- `tmpw` matches `templates/pages/workout.templ`
- `hlapi` matches `handlers/api/climb.go`

**Implementation**: Telescope indexes your project (respecting `.gitignore`), then filters interactively. Results update as you type.

**Navigation**: `<C-j>` and `<C-k>` (or arrow keys) move through results. `<CR>` opens selected file.

**Preview**: Right panel shows file preview. Review file content before opening.

**Live Grep** (`<leader>fg`): Search file contents project-wide. VSCode's Ctrl+Shift+F equivalent.

Type search pattern, Telescope shows matching lines with file paths and line numbers. Navigate results, preview in context, press Enter to jump to match.

**Additional Telescope Pickers**:
- `<leader>fb` - Browse open buffers
- `<leader>fr` - Recent files
- `<leader>fg` - Git files
- `<leader>fh` - Help tags (documentation)

### Telescope Workflow

Typical file opening sequence:

1. Press `<leader>ff`
2. Type partial filename (e.g., "climb")
3. Telescope shows matches: `climb.go`, `climb.templ`, `climb_service.go`
4. Navigate with `<C-j>`/`<C-k>`
5. Preview each file in right pane
6. Press `<CR>` to open

This is faster than mouse-navigating a file tree: direct path to target via fuzzy matching.

### Telescope Advanced Features

**Multi-Select**: Press `<Tab>` to select multiple files. `<CR>` opens all selected files.

**Actions**: In Telescope, press `<C-q>` to send results to quickfix. Useful for search results you'll navigate repeatedly.

**History**: Telescope remembers previous searches. `<C-p>` and `<C-n>` cycle through search history.

**Smart Case**: Lowercase searches are case-insensitive. Include uppercase to make case-sensitive.

### Neo-tree: File Browser

Neo-tree provides a familiar sidebar file tree, similar to VSCode's Explorer.

**Toggle/Focus** (`<leader>e`): Your `keymaps.lua:7-18` customizes this. First press opens Neo-tree. Subsequent presses focus it if already open.

**Navigation**: `j` and `k` move through files/directories. `<CR>` opens files or toggles directory expansion.

**File Operations**:
- `a` - Add (create new file/directory)
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste

**Window Behavior**: Neo-tree opens in a left sidebar. Press `<leader>e` from Neo-tree to return to previous window.

### Neo-tree vs. Telescope

When to use each:

**Telescope** (preferred for most navigation):
- Quick file opening via fuzzy search
- Searching file contents
- Browse buffers or recent files
- Unknown exact file location

**Neo-tree** (for exploration and operations):
- Exploring project structure
- Understanding directory hierarchy
- File operations (create, delete, rename)
- Visual browsing when unsure what you're looking for

Your workflow might favor Telescope: `<leader>ff` is faster than navigating a file tree when you know the filename.

### LSP-Based Navigation

Language servers enable code-aware navigation:

**Go to Definition** (`gd`): Jump to where a function, type, or variable is defined.

Example: Cursor on `WorkoutService` in climb-tracker, press `gd`. Neovim opens `internal/services/workout_service.go` at the struct definition.

**Go to Declaration** (`gD`): Jump to type declarations. Useful for Go interfaces.

**Go to References** (`gr`): Show all usages of symbol under cursor. Opens location list with every reference.

**Go to Implementation** (`gi`): For interfaces, jump to implementations.

**LSP Navigation Workflow**: Place cursor on identifier, press navigation key. No searching required—LSP understands code structure.

### The Jump List

Neovim maintains a jump list of cursor positions:

**Backward** (`<C-o>`): Jump to previous cursor position. Repeatedly pressing `<C-o>` navigates backward through jump history.

**Forward** (`<C-i>`): Jump forward through jump list.

**Use Case**: Use `gd` to jump to definition, review code, then `<C-o>` to return to original location. No manual navigation required.

**What Triggers Jumps**: LSP navigation (`gd`, `gr`), searching (`/`, `?`), file opening, and line jumps (`G`, `gg`).

### Marks

Marks are named cursor positions:

**Setting Marks**: `m` followed by a letter. `ma` sets mark 'a' at current position.

**Jumping to Marks**: `'a` jumps to mark 'a' line. `` `a `` jumps to exact column.

**Local vs. Global**:
- Lowercase marks (`ma` through `mz`) are file-local
- Uppercase marks (`mA` through `mZ`) are global across files

**Use Case**: Set `mA` at important location, navigate elsewhere, then `` `A `` returns instantly.

**Viewing Marks**: `:marks` lists all marks and their locations.

### File Path Navigation

Neovim includes file path-aware navigation:

**`gf` (Go to File)**: With cursor on a file path or import statement, `gf` opens that file.

Example in Go: Cursor on `"github.com/labstack/echo/v4"` import, press `gf`. Neovim attempts to open that file (requires path configuration).

**`gx` (Go to URL)**: Opens URLs under cursor in browser. Useful for documentation links in comments.

Your climb-tracker often imports local packages. `gf` on `"climb-tracker/internal/models"` could navigate to that package.

### Buffer Navigation

Switching between recently opened files:

**Buffer Switching**:
- `<S-h>` - Previous buffer (like browser back button)
- `<S-l>` - Next buffer (like browser forward button)
- `<leader><leader>` - Toggle between last two buffers

**Buffer Finding**: `<leader>fb` opens Telescope's buffer picker. Fuzzy find open buffers.

**Use Case**: Working on handler (`workout.go`) and model (`workout.go` in models). `<leader><leader>` toggles between them instantly.

### Project-Specific Navigation

Your climb-tracker's structure suggests navigation patterns:

**Three-Layer Architecture** (handlers → services → models):

1. Open handler: `<leader>ff` → "api/workout"
2. Jump to service call: `gd` on service method
3. Jump to model: `gd` on model type
4. Return to handler: `<C-o>` twice

**Template Editing** (handler → template):

1. Handler: `internal/handlers/frontend/workout.go`
2. Find template: `<leader>ff` → "workout.templ"
3. Toggle between: `<leader><leader>`

**Test-Driven Development** (test → implementation):

1. Test: `tests/e2e/smoke/critical-path.spec.ts`
2. Find handler: `<leader>ff` → "workout"
3. Jump between: `<S-h>` / `<S-l>`

### Git-Aware Navigation

Git integration enhances navigation:

**Changed Files**: Plugins can list git-modified files for quick access to recent work.

**Hunks** (changed sections): `]h` and `[h` navigate to next/previous git hunk. Review changes while editing.

**Merge Conflicts**: Some git plugins highlight conflicts and provide navigation between conflict markers.

Your git.lua enables inline blame (line 3-9), showing commit info while navigating code.

### Search-Based Navigation

Traditional Vim search integrated with modern tools:

**In-File Search**: `/pattern` searches forward, `?pattern` searches backward. `n` and `N` navigate matches.

**Project-Wide Search**: `<leader>fg` for live grep. Results in Telescope for interactive navigation.

**Search and Replace**: After searching, `:%s/old/new/g` replaces all occurrences.

**Search Highlight**: LazyVim highlights all search matches. Clear with `:noh`.

### File Navigation Shortcuts

Additional navigation helpers:

**Current Directory**: `:e .` opens file browser in current directory (Neovim's built-in netrw).

**File Under Cursor**: `gf` opens file path under cursor.

**Alternate File**: `<C-^>` or `:e#` opens the alternate file (previous buffer in current window).

**Jump to Line**: `15G` or `:15` jumps to line 15.

### Practical Navigation Strategies

**Hybrid Approach**: Combine tools based on context:

- **Known filename**: `<leader>ff` → type partial name
- **Unknown location**: `<leader>fg` → search for distinctive string
- **Following code**: `gd` → jump to definition
- **Exploring structure**: `<leader>e` → browse file tree
- **Recent file**: `<leader>fb` → find in open buffers

**Minimize Mouse**: All navigation is keyboard-driven. Muscle memory for `<leader>ff`, `gd`, and `<C-o>` eliminates mouse dependency.

**Leverage LSP**: When editing code, prefer LSP navigation (`gd`, `gr`) over manual searching. LSP understands code semantically.

**Use Jump List**: Don't worry about navigating back. `<C-o>` always returns to previous location.

### Your Configuration's Navigation Setup

Your LazyVim configuration provides:

**Telescope** (LazyVim default): All fuzzy finding keybindings pre-configured.

**Neo-tree** (via LazyVim extra): Customized in `keymaps.lua` for toggle/focus behavior.

**LSP Navigation** (via lang extras): `gd`, `gr`, `gi` work automatically in Go, TypeScript, templ files due to your lang.go, lang.typescript, and templ.lua configurations.

**Gitsigns** (in git.lua): Hunk navigation with `]h` and `[h`.

**Buffer Management** (LazyVim default): `<S-h>`, `<S-l>`, `<leader>fb` all functional.

This comprehensive navigation setup eliminates VSCode's reliance on mouse and sidebar. Every file is accessible via a few keystrokes.

---


## Chapter 10: Your LazyVim Setup

### Configuration Overview

Your Neovim configuration in `~/.config/nvim/` is tailored for full-stack development on the climb-tracker project. The setup balances LazyVim's curated defaults with project-specific customizations.

**Stack-Specific Plugins**:
- Go with gopls LSP
- templ templates with LSP support
- Tailwind CSS v4 with language server
- TypeScript/Playwright for testing
- PostgreSQL via vim-dadbod
- Docker and Make file support

**Workflow Enhancements**:
- GitHub PR management (octo.nvim)
- Git inline blame
- Auto-save on focus loss
- HTMX attribute awareness

### Entry Point: init.lua

Your `~/.config/nvim/init.lua` contains a single line:

```lua
require("config.lazy")
```

This bootstraps LazyVim. The `require` loads `lua/config/lazy.lua`, which:

1. Installs lazy.nvim if not present
2. Configures the plugin manager
3. Loads LazyVim core
4. Imports your custom configurations from `lua/config/`
5. Imports your plugin specifications from `lua/plugins/`

This minimal entry point demonstrates LazyVim's philosophy: convention over configuration.

### Core Configurations (lua/config/)

These files override LazyVim defaults:

**options.lua** - Editor Behavior:

```lua
vim.opt.relativenumber = false  -- Line 5: Absolute line numbers only
vim.opt.number = true           -- Line 6: Show line numbers

-- Go-specific (Lines 9-14)
vim.opt.tabstop = 4             -- Tabs display as 4 spaces
vim.opt.shiftwidth = 4          -- Auto-indent uses 4 spaces
vim.opt.expandtab = false       -- Use real tabs, not spaces
```

**Why These Settings**: Go convention uses tabs for indentation. Your configuration respects this, ensuring code matches gofmt output. This applies globally since climb-tracker is primarily Go.

**autocmds.lua** - Automatic Commands:

```lua
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wa",
  desc = "Auto-save all buffers on focus loss or buffer leave",
})
```

**Why Auto-Save**: HTMX development involves frequent browser testing. This prevents losing changes when switching to browser. The `silent!` suppresses errors for unsavable buffers (terminals).

**keymaps.lua** - Custom Keybindings:

```lua
vim.keymap.set("n", "<leader>e", function()
  local neotree_bufnr = vim.fn.bufnr("neo-tree")
  local neotree_window = vim.fn.win_findbuf(neotree_bufnr)
  
  if #neotree_window == 1 and vim.fn.winnr() ~= neotree_window then
    vim.fn.win_gotoid(neotree_window[1])
  else
    vim.cmd("Neotree toggle")
  end
end, { desc = "Toggle or focus Neo-tree" })
```

**Why This Customization**: Default behavior toggles Neo-tree (open → close, close → open). Your version focuses Neo-tree if already open, providing VSCode-like sidebar behavior.

### Language Support Plugins

**go.lua** - Go Development:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.go" },
}
```

This single line provides:
- gopls LSP (code intelligence)
- gofmt/goimports (formatting on save)
- Go test integration
- Delve debugger configuration
- Go-specific keybindings

**Why Import Instead of Manual Config**: LazyVim extras are pre-configured, tested, and maintained. One line replaces ~50 lines of manual LSP setup.

**templ.lua** - Template Language Support:

```lua
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
}
```

**What This Enables**: Type-safe template editing for files in `internal/templates/`. LSP provides:
- Type checking for data passed from handlers
- Completion for Go variables
- Syntax validation
- Go-to-definition in templates

**typescript.lua** - TypeScript/Playwright:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
```

**Purpose**: Provides tsserver LSP for Playwright tests in `tests/e2e/`. Enables:
- TypeScript completion
- Type checking
- Import management
- Error detection

**tailwind.lua** - CSS Framework Support:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.tailwindcss" },
}
```

**What This Provides**: Tailwind CSS language server for class completion and documentation. Critical for:
- Class name completion in templ templates
- Hover documentation for utilities
- CSS variable support (e.g., `[var(--variable-name)]` syntax in your dark theme)

### Infrastructure Plugins

**docker.lua** - Container Support:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "dockerfile" })
  end,
}
```

**Purpose**: Syntax highlighting for `docker-compose.yml` and Dockerfiles. Minimal but essential for container-based development.

**sql.lua** - Database Access:

```lua
{
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql" } },
  },
  cmd = { "DBUI", "DBUIToggle" },
}
```

**What This Enables**: Direct PostgreSQL access from Neovim:
- `:DBUIToggle` opens database UI
- Navigate tables and schemas
- Execute queries
- View results inline

**Connection**: Configure connection string for `localhost:5433` (your PostgreSQL port).

**make.lua** - Build System Support:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "make" })
  end,
}
```

**Purpose**: Syntax highlighting for your `Makefile`. Supports your build workflow (`make build`, `make dev`, `make build-templ`).

### Workflow Plugins

**git.lua** - Enhanced Git Integration:

```lua
{
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
  },
}
```

**What This Adds**: Inline git blame showing commit info after 500ms on a line. Complements LazyVim's included gitsigns and lazygit integration.

**Navigation**: `]h` and `[h` jump between changed sections (hunks).

**octo.lua** - GitHub Integration:

```lua
{
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  config = function()
    require("octo").setup({ ... })
  end,
}
```

**What This Enables**: Full GitHub PR workflow from Neovim:
- `:Octo pr list` - View open PRs
- `:Octo pr view` - Read PR description and comments
- `:Octo pr comments` - Review and respond to feedback
- `:Octo pr create` - Create draft PRs

**Why This Matters**: Your workflow (documented in `climb-tracker/.ai-context.md`) emphasizes PR-based development. Managing PRs from Neovim eliminates browser context switching.

**htmx.lua** - Frontend Framework Support:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "html" })
  end,
}
```

**Purpose**: Enhanced HTML support for HTMX attributes (`hx-get`, `hx-target`, `hx-swap`) in templ templates. Minimal configuration for specific workflow need.

### Optional/Advanced Plugins

**dap.lua** - Debugging:

```lua
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

**What This Provides**: Debug Adapter Protocol support:
- Set breakpoints with `<leader>db`
- Step through code with `<leader>di`, `<leader>do`
- Inspect variables in real-time
- Debug Go handlers and services

**Usage**: Optional but powerful for debugging complex business logic in `internal/services/`.

**playwright.lua** - Test Runner:

```lua
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-playwright",
  },
  opts = {
    adapters = {
      ["neotest-playwright"] = { ... },
    },
  },
}
```

**What This Enables**: Run Playwright tests from Neovim:
- `<leader>tt` - Run test at cursor
- `<leader>tf` - Run all tests in file
- See results inline
- Jump to failures

**Alternative**: Run tests in terminal (`<leader>ft` → `npm run test:e2e`). This plugin provides tighter integration.

### Configuration Philosophy

Your setup demonstrates several principles:

**Minimal Extras**: Only enabled extras (go, typescript, tailwindcss, dap) are actively used. No unused plugins.

**Documented Rationale**: Each plugin file (e.g., `go.lua`) includes comments explaining why it exists and what it provides.

**Project-Specific**: Plugins address climb-tracker's stack (Go, templ, HTMX, PostgreSQL), not generic development.

**LazyVim Foundation**: Leverages LazyVim defaults (Telescope, Neo-tree, LSP) rather than reinventing them.

### Load Order and Dependencies

When Neovim starts with your configuration:

1. **init.lua** → `require("config.lazy")`
2. **lazy.lua** bootstraps lazy.nvim and LazyVim
3. **options.lua** sets editor options (tabs, line numbers)
4. **autocmds.lua** registers auto-save
5. **keymaps.lua** customizes Neo-tree keybinding
6. **LazyVim core** loads default plugins (Telescope, Treesitter, LSP)
7. **Your plugins/** load:
   - Language extras (go, typescript, tailwind) install LSP servers
   - Infrastructure plugins (docker, sql, make) add syntax support
   - Workflow plugins (git, octo, htmx) enhance editing
   - Optional plugins (dap, playwright) available on-demand
8. **Lazy loading** defers most plugins until needed

Result: Fast startup (~20-50ms) despite many plugins.

### Customization Points

Your configuration is extensible at several points:

**Add Language Support**: Create `lua/plugins/rust.lua` → `{ import = "lazyvim.plugins.extras.lang.rust" }` for Rust development.

**Add Keybindings**: Extend `lua/config/keymaps.lua` with additional mappings.

**Modify LSP**: Override LSP server settings in existing plugin files.

**Add Plugins**: Create new file in `lua/plugins/` returning plugin specification.

**Remove Plugins**: Delete plugin file, run `:Lazy clean`.

### Maintenance Workflow

Keeping your configuration current:

**Update Plugins**: `:Lazy update` updates all plugins to latest commits.

**Check Health**: `:checkhealth` diagnoses configuration issues.

**Review Changes**: `:Lazy log` shows recent plugin updates.

**Lock Versions**: `lazy-lock.json` tracks exact plugin versions. Commit this for reproducible configuration.

**Update Extras**: `:LazyExtras` shows available extras. Enable new ones by adding imports to plugin files.

### Integration with climb-tracker

Your configuration explicitly supports climb-tracker's workflow:

**Development Cycle**:
1. `nvim` in project root
2. `<leader>gg` for git status (lazygit)
3. `<leader>ff` to open handler
4. Edit with LSP completion and error checking
5. Auto-save on focus loss when switching to browser
6. `:Octo pr create` for draft PR
7. `:Octo pr comments` to review feedback

**Tech Stack Coverage**:
- Go: LSP, formatting, testing, debugging
- templ: Syntax, LSP, type checking
- Tailwind: Class completion, hover docs
- TypeScript: Playwright test support
- PostgreSQL: Direct database access
- Docker: Compose file syntax
- Makefile: Build command support

Every component of your stack has corresponding Neovim integration.

### Configuration Documentation

Your configuration includes three documentation files:

**README.md**: Plugin recommendations and rationale. Explains why each plugin exists and how it supports climb-tracker.

**REFERENCE.md**: Quick keybinding reference. Your primary cheat sheet for common operations.

**.ai-context.md**: Context for AI pair programming. Preferences, workflow notes, configuration philosophy.

These documents maintain the "why" behind your configuration choices.

---


## Chapter 11: Language-Specific Features

### Go Development Environment

Your Go setup provides comprehensive language support through the `lang.go` extra and gopls LSP.

**Code Completion**: Type `http.` and gopls suggests `http.Get`, `http.Post`, `http.Handler`, etc. Works for:
- Standard library packages
- Local packages (`climb-tracker/internal/models`)
- Third-party imports (`github.com/labstack/echo/v4`)
- Struct methods and fields

**Error Detection**: gopls analyzes code in real-time:
- Type errors highlight immediately
- Unused imports marked for removal
- Missing error handling flagged
- Undefined variables caught

**Formatting**: gofmt and goimports run automatically on save:
- Enforces Go style (tabs, spacing, braces)
- Adds missing imports
- Removes unused imports
- Organizes import statements

**Go-Specific Commands**:
- `<leader>td` - Run test at cursor
- `<leader>tD` - Run all tests in file
- `<leader>ct` - Generate struct tags (json, form, etc.)
- `<leader>ci` - Organize imports

**Navigation**:
- `gd` on `WorkoutService` jumps to struct definition
- `gr` on method shows all callers
- `gi` on interface jumps to implementations

### templ Template Development

Your templ configuration (`lua/plugins/templ.lua`) provides type-safe template editing.

**Syntax Highlighting**: Treesitter understands templ's mix of HTML and Go:
- HTML tags colored appropriately
- Go expressions within templates highlighted as Go
- Template directives recognized

**LSP Integration**: templ LSP provides:
- Type checking for variables passed from handlers
- Completion for Go variables in templates
- Error detection when template expects different data types
- Go-to-definition from template to handler

**Example Workflow**:
1. Handler passes `*models.Workout` to template
2. Template uses `workout.StartTime`
3. LSP validates `StartTime` field exists
4. Renaming field in model highlights template error

**Filetype Detection**: `.templ` files automatically activate templ LSP and Treesitter.

### TypeScript/JavaScript for Tests

The `lang.typescript` extra supports Playwright test development.

**TypeScript LSP** (tsserver):
- Completion for Playwright API (`page.goto`, `expect`, etc.)
- Type checking in `tests/e2e/` files
- Import management
- Error detection

**ESLint Integration**: Linting rules enforce:
- Code style consistency
- Best practices
- Potential bugs

**Test File Support**:
- `.spec.ts` files recognized
- Test framework completions
- Async/await syntax support

### Tailwind CSS Support

The `lang.tailwindcss` extra provides Tailwind-specific intelligence.

**Class Completion**: In templ templates, typing `class="flex` triggers completion showing:
- `flex`
- `flex-row`
- `flex-col`
- `flex-wrap`
- ...all flex utilities

**Hover Documentation**: Hover over Tailwind class shows:
- Generated CSS
- CSS property values
- Variant information

**CSS Variables**: Your dark theme uses arbitrary values (`[var(--color-primary)]`). Tailwind LSP understands these.

**Config Awareness**: Tailwind LSP reads `tailwind.config.js`, knowing:
- Custom colors
- Custom utilities
- Theme extensions

### SQL Development

Your `sql.lua` configuration provides PostgreSQL support.

**vim-dadbod UI**:
- `:DBUIToggle` opens database explorer
- Navigate tables with `j`/`k`
- Expand with `o`
- Execute queries with `<leader>S`

**SQL Completion**:
- Table name completion
- Column name completion
- SQL keyword completion
- PostgreSQL-specific syntax

**Query Execution**:
- Write query in buffer
- Select with Visual mode
- `<leader>S` executes selection
- Results appear in new buffer

**Use Cases**:
- Verify data after API calls
- Debug GORM queries
- Explore schema structure
- Test complex queries before adding to code

### Dockerfile and Docker Compose

Your `docker.lua` provides container file support.

**Syntax Highlighting**:
- Dockerfile keywords (`FROM`, `RUN`, `COPY`)
- docker-compose.yml structure
- Environment variable references

**Validation**:
- Invalid instruction detection
- Syntax error highlighting

**Integration**: Edit `docker-compose.yml`, see changes highlighted. Validate before running `docker-compose up`.

### Makefile Support

Your `make.lua` enables Makefile editing.

**Syntax Highlighting**:
- Target names
- Variables (`$(VARIABLE)`)
- Shell commands
- Comments

**Tab Handling**: Makefiles require real tabs. Your configuration (referenced in `options.lua` comments) ensures proper tab handling.

**Integration with :make**: Run `:make target_name` to execute Makefile targets. Errors populate quickfix list.

### HTMX Attribute Awareness

Your `htmx.lua` enhances HTML editing for HTMX attributes.

**Enhanced HTML**: Treesitter HTML parser recognizes:
- `hx-get`, `hx-post` attributes
- `hx-target`, `hx-swap` directives
- `hx-trigger` event specifications

**Template Context**: Works in templ templates where you use HTMX for dynamic UI updates.

**Use Case**: Editing `internal/templates/components/workout.templ` with HTMX attributes gets proper syntax highlighting.

### Debugging Go Code

Your `dap.lua` enables Go debugging with Delve.

**Setting Breakpoints**:
- `<leader>db` toggles breakpoint on current line
- Red dot appears in gutter

**Starting Debugger**:
- `<leader>dc` starts debugging
- Code execution pauses at breakpoints

**Stepping**:
- `<leader>di` steps into function
- `<leader>do` steps over line
- `<leader>dO` steps out of function

**Inspecting Variables**:
- Hover over variables to see values
- REPL for evaluating expressions

**Use Cases**:
- Debug complex service logic
- Inspect GORM query results
- Trace request handling through Echo handlers

### Testing Integration

Your `playwright.lua` provides test runner integration.

**Running Tests**:
- `<leader>tt` runs test at cursor
- `<leader>tf` runs all tests in file
- `<leader>ts` runs entire suite

**Results Display**:
- Inline pass/fail indicators
- Jump to failures
- View error messages

**Alternative Workflow**: Run tests in terminal (`<leader>ft` → `npm run test:e2e`) for full output.

### Language Server Status

Check LSP server status per filetype:

**Go files**: `:LspInfo` shows gopls running, capabilities listed

**templ files**: templ LSP active, providing template checking

**TypeScript files**: tsserver running, type checking enabled

**SQL files**: sqlls active, query validation available

**Tailwind contexts**: tailwindcss LSP active in HTML/templ files

### Cross-Language Features

Some features work across all languages:

**Completion**: LSP-based completion in all supported languages

**Diagnostics**: Error highlighting and quickfix for all LSPs

**Formatting**: Language-specific formatters on save:
- Go: gofmt + goimports
- TypeScript: prettier
- SQL: pg_format (if configured)

**Go-to-Definition**: Works in Go, TypeScript, templ, SQL (for procedures)

---

## Chapter 12: Workflow Integration

### Git Workflow

Your git configuration integrates with LazyVim's git tools.

**lazygit** (`<leader>gg`):
- Opens in floating terminal
- Full git interface (stage, commit, push, pull, rebase)
- Visual branch navigation
- Commit history
- File diffs

**Workflow**:
1. Edit code, save automatically
2. `<leader>gg` opens lazygit
3. Review changes with visual diffs
4. Stage hunks or files
5. Write commit message
6. Push to remote
7. Close lazygit

**gitsigns**:
- Inline blame (shows commit after 500ms)
- Hunk navigation (`]h`, `[h`)
- Stage hunk: `<leader>ghs`
- Undo hunk: `<leader>ghr`
- Preview hunk: `<leader>ghp`

**Use Case**: Hunk navigation lets you review changes before committing. Jump through modified sections, stage good changes, reset mistakes.

### GitHub PR Workflow

Your octo.nvim configuration supports PR-based development.

**Creating PRs**:
```vim
:Octo pr create
```
Opens buffer for PR title and description. Save to create draft PR on GitHub.

**Viewing PRs**:
```vim
:Octo pr list
```
Shows all PRs. Navigate, press `<CR>` to open selected PR.

**Reviewing Comments**:
```vim
:Octo pr comments
```
Lists all comments on current PR. Read feedback, respond inline.

**Integration with gh CLI**: octo.nvim uses `gh` CLI underneath. Authenticate once (`gh auth login`), octo.nvim works automatically.

**Your Workflow** (from `climb-tracker/.ai-context.md`):
1. Create feature branch: `git checkout -b feature/name`
2. Make changes, commit via lazygit
3. `:Octo pr create` for draft PR
4. Request review, receive feedback
5. `:Octo pr comments` to read comments
6. Make changes, commit, push
7. `:Octo pr ready` marks PR ready
8. Merge via `gh pr merge --squash`

### Development Server Workflow

Your terminal integration enables server development.

**Starting Server**:
1. `<leader>ft` opens floating terminal
2. `./scripts/start-dev.sh` starts server
3. `<C-/>` or `<Esc><Esc>` hides terminal (server keeps running)

**Editing Workflow**:
1. Edit handler in `internal/handlers/`
2. Save (auto-saves on focus loss)
3. templ regenerates if needed (`make build-templ`)
4. Server hot-reloads
5. Switch to browser, test changes

**Viewing Logs**:
- `<C-/>` shows terminal with server logs
- Review request logs
- Check for errors
- Hide with `<C-/>` again

### Database Interaction

Two approaches for database work:

**vim-dadbod** (structured):
1. `:DBUIToggle` opens database UI
2. Navigate to table
3. Press `o` to view data
4. Write query in new buffer
5. `<leader>S` executes query
6. Results appear inline

**Terminal psql** (flexible):
1. `<leader>ft` opens terminal
2. `psql postgresql://user:pass@localhost:5433/climb_tracker`
3. Run queries interactively
4. Use `\d` commands for schema
5. `<C-\><C-n>` to exit terminal mode, yank output
6. Paste into code or documentation

### Build System Integration

Your Makefile workflow:

**Common Targets**:
- `make build` - Build Go binary
- `make dev` - Run development server
- `make build-templ` - Regenerate templ templates
- `make build-css` - Rebuild Tailwind CSS
- `make db-up` - Start PostgreSQL container

**From Neovim**:
1. `<leader>ft` opens terminal
2. `make build-templ` rebuilds templates
3. Check output for errors
4. `<C-/>` hides terminal

**Using :make**:
- `:make build` runs `make build`
- Errors populate quickfix
- `]q` jumps to first error
- Fix, save, `:make build` again

### Testing Workflow

Multiple testing approaches:

**E2E Tests (Terminal)**:
1. `<leader>ft` → `npm run test:e2e`
2. Watch Playwright execution
3. Review results
4. `<C-\><C-n>` to copy error output
5. Paste into code for reference

**E2E Tests (Neotest)** (if using playwright.lua):
1. Open test file
2. `<leader>tt` runs test at cursor
3. See pass/fail inline
4. `<leader>to` shows output
5. Jump to failures

**Go Tests**:
1. Open test file (`*_test.go`)
2. `<leader>td` runs test under cursor
3. Results in terminal
4. Fix code, run again

### Multi-File Editing

Workflow for features spanning multiple files:

**Example: Adding Climb Field**:
1. **Model**: `<leader>ff` → "models/climb" → add field
2. **Migration**: Split (`<leader>w|`) → edit migration
3. **Handler**: `<leader>ff` → "handlers/api/climb" → update
4. **Template**: `<leader>w-` → "components/climb.templ" → add UI
5. Navigate with `<C-hjkl>`
6. Edit in each split
7. Auto-save on focus loss
8. Close splits: `<leader>wd`

**Buffer Switching**:
- `<leader><leader>` toggles between last two files
- `<S-h>` / `<S-l>` cycles through open buffers
- `<leader>fb` fuzzy finds buffer

### Documentation While Coding

**Hover Documentation** (`K`):
- Cursor on function name
- Press `K`
- See signature, parameters, return types
- Press `K` again to jump into hover window
- Scroll through long docs

**Go to Definition** (`gd`):
- Cursor on type or function
- Press `gd`
- Jump to definition
- Read source code and comments
- `<C-o>` to return

**References** (`gr`):
- Cursor on symbol
- Press `gr`
- See all usages
- Navigate through examples
- Understand usage patterns

### Search and Replace Workflow

**Project-Wide Replace**:
1. `<leader>fg` → search for pattern (e.g., "Workout")
2. Review matches in Telescope preview
3. `<C-q>` sends to quickfix
4. `:%s/Workout/Session/g` in quickfix to rename in all files
5. Or manually navigate (`]q`) and fix each

**Single File Replace**:
1. `/pattern` to search
2. `:%s/old/new/gc` for interactive replace
3. Confirm each replacement (`y`/`n`)

### Refactoring Workflow

**Renaming Symbols**:
1. Cursor on function/variable name
2. `<leader>cr` (LSP rename)
3. Type new name
4. Press Enter
5. LSP updates all references across project

**Extract Function**:
1. Visual mode select code block
2. `<leader>ca` (code actions)
3. Select "Extract function" if available
4. LSP performs refactoring

### Focus and Context Switching

**Minimal Context Switching**:
- Code editing → Neovim
- Git operations → lazygit in Neovim (`<leader>gg`)
- GitHub PRs → octo.nvim in Neovim (`:Octo pr`)
- Database queries → vim-dadbod in Neovim (`:DBUIToggle`)
- Server logs → terminal in Neovim (`<leader>ft`)
- Testing → terminal or neotest in Neovim

**Only Browser Needed**: UI testing and design review. Everything else happens in Neovim.

---


## Chapter 13: Daily Development Workflow

### Morning Startup

Typical session initialization:

1. **Terminal**: `cd ~/dev/climb-tracker && nvim`
2. **Neovim Opens**: LazyVim loads in ~20-50ms
3. **Git Status**: `<leader>gg` to check current state
4. **Identify Work**: View branch name, staged changes, recent commits
5. **Open Files**: `<leader>ff` → fuzzy find relevant files
6. **Start Server** (if needed): `<leader>ft` → `./scripts/start-dev.sh`

Configuration supports this: auto-save, LSP, quick navigation all ready immediately.

### Feature Development Cycle

**Phase 1: Planning**
1. Review user story (e.g., `docs/user_stories/phase-6-picture-first-climb.md`)
2. Identify files to modify
3. `<leader>ff` → open first file

**Phase 2: Implementation**
1. Edit handler (`internal/handlers/api/workout.go`)
   - LSP provides completion
   - gopls shows errors in real-time
   - Auto-save on focus loss
2. `<leader>ff` → open model (`internal/models/workout.go`)
   - `gd` on types to check fields
   - Add database fields
3. `<leader>ff` → open template (`internal/templates/components/workout.templ`)
   - templ LSP validates data types
   - Tailwind completion for styling
4. Switch to browser to test
   - Changes auto-saved
   - Server hot-reloaded

**Phase 3: Testing**
1. `<leader>ft` → `npm run test:e2e`
2. Watch tests execute
3. Failures → `<C-\><C-n>` → yank error
4. Fix code based on error
5. Repeat

**Phase 4: Review**
1. `<leader>gg` → lazygit
2. Review diffs
3. Stage changes
4. Commit with meaningful message
5. Push to remote

**Phase 5: PR Creation**
1. `:Octo pr create`
2. Write PR description
3. Save to create draft PR
4. Request review

### Bug Investigation Workflow

**Step 1: Reproduce**
1. Note error in browser/logs
2. `<leader>ft` → check server logs
3. Identify failing endpoint

**Step 2: Locate**
1. `<leader>fg` → search for error message or endpoint name
2. `<C-q` → send to quickfix
3. `]q` → navigate to relevant code

**Step 3: Context**
1. `gd` on functions to trace execution
2. `gr` on models to see all usages
3. `<leader>w|` → split for related files

**Step 4: Debug**
- Option A: Add logging, restart server, check logs
- Option B: `<leader>db` → set breakpoint, `<leader>dc` → start debugger

**Step 5: Fix**
1. Edit code with LSP guidance
2. Save (auto-saves on focus loss)
3. Test in browser
4. Verify server logs

**Step 6: Validate**
1. Run relevant tests
2. Check database state (`:DBUIToggle`)
3. Ensure fix doesn't break other features

### Refactoring Session

**Goal**: Rename `Workout` to `Session` across project

1. **Search First**: `<leader>fg` → "Workout" → review all occurrences
2. **Systematic Rename**:
   - Open `internal/models/workout.go`
   - Cursor on `Workout` struct
   - `<leader>cr` → type "Session"
   - LSP renames across all files
3. **File Renames**:
   - `:!git mv internal/models/workout.go internal/models/session.go`
   - Update imports manually (gopls may assist)
4. **Verification**:
   - `<leader>xx` → check for LSP errors
   - `]d` → navigate to each error
   - Fix remaining issues
5. **Testing**:
   - `<leader>ft` → `make build` → ensure compilation succeeds
   - Run tests to verify behavior unchanged

### Code Review Integration

**Responding to PR Comments**:

1. `:Octo pr comments` → read feedback
2. For each comment:
   - Note file and line
   - `<leader>ff` → open file
   - `15G` → jump to line (if line 15)
   - Make requested change
3. After all changes:
   - `<leader>gg` → lazygit
   - Commit with "Address PR feedback"
   - Push
4. `:Octo pr comments` → respond to comments

### Database Schema Evolution

**Adding Migration**:

1. `<leader>ff` → create migration file
2. Write SQL with sqlls LSP validation
3. `:DBUIToggle` → connect to database
4. Test migration in dadbod UI
5. If successful, apply via migration tool

**Verifying Data**:

1. After API call, check database:
   - `:DBUIToggle`
   - Navigate to table
   - `o` → view data
2. Compare with expected state
3. Debug discrepancies in handler code

### Template Development

**HTMX Component Workflow**:

1. Edit template: `<leader>ff` → "components/workout.templ"
2. Add HTMX attributes:
   - `hx-get` with LSP-validated Go handler path
   - Tailwind classes with completion
   - templ syntax with type checking
3. `<leader>ft` → `make build-templ` → regenerate
4. Switch to browser, test interaction
5. Adjust styling:
   - Edit Tailwind classes
   - `make build-css` if needed
   - Browser hard-refresh (Cmd+Shift+R)

### Multi-Feature Day

**Context Switching Between Features**:

Use tabs or buffer management:

**Tab Approach**:
1. `:tabnew` → new tab for second feature
2. Set up splits for feature 2
3. `gt` → switch tabs
4. Each tab has different window layout

**Buffer Approach** (more common):
1. Close splits: `<leader>wd`
2. `<leader>fb` → find buffers for feature 2
3. Open relevant files
4. `<leader><leader>` toggles between recent files

### End of Day Routine

1. **Review Changes**:
   - `<leader>gg` → lazygit
   - Check uncommitted changes
   - Stash if incomplete: press `s` in lazygit on changes

2. **Check PR Status**:
   - `:Octo pr list`
   - Note any new comments
   - Plan next day's responses

3. **Close Gracefully**:
   - `<leader>qq` → quit all windows
   - Or just close terminal (Neovim sessions persist)

---

## Chapter 14: Advanced Techniques

### Custom Keybindings

Extend `lua/config/keymaps.lua`:

```lua
-- Quick build-templ shortcut
vim.keymap.set("n", "<leader>mt", function()
  vim.cmd("terminal make build-templ")
end, { desc = "Make build-templ" })

-- Quick restart server
vim.keymap.set("n", "<leader>mr", function()
  vim.cmd("terminal ./scripts/start-dev.sh")
end, { desc = "Restart dev server" })
```

**Purpose**: Frequently-used commands become single keystrokes.

### Advanced LSP Configuration

Customize gopls in `lua/plugins/go.lua`:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.go" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
        },
      },
    },
  },
}
```

**What This Adds**:
- Unused parameter warnings
- Shadow variable detection
- staticcheck integration (advanced Go linting)

### Macros for Repetitive Edits

**Recording Macros**:
1. `qa` → start recording to register 'a'
2. Perform edit operations
3. `q` → stop recording
4. `@a` → replay macro

**Example**: Add `json` tags to struct fields:
1. `qa` → start recording
2. `f }` → jump to end of field
3. `a json:"field_name"<Esc>` → add tag
4. `j0` → next line, start
5. `q` → stop
6. `@a` → repeat for each field

**Dot Command**: For simpler repetitions, `.` repeats last change without macro overhead.

### Search and Replace Patterns

**Regex Search**:
```vim
/\v(Workout|Session)  " Find either word
```

**Global Replace**:
```vim
:%s/Workout\(\w\+\)/Session\1/g  " WorkoutService → SessionService
```

**Quickfix Replace**:
1. `<leader>fg` → grep "pattern"
2. `<C-q>` → send to quickfix
3. `:cdo s/old/new/g | update` → replace in all quickfix files

### Advanced Git Integration

**Git Blame**:
- Inline blame shows automatically (your `git.lua` config)
- `<leader>gb` → see full blame for line

**Hunk Operations**:
- `<leader>ghs` → stage hunk
- `<leader>ghr` → reset hunk
- `<leader>ghp` → preview hunk

**lazygit Advanced**:
- Rebasing: enter rebase mode in lazygit
- Fixup commits: mark commits for squashing
- Cherry-picking: select and apply commits

### Buffer-Local Settings

Create filetype-specific autocmds in `lua/config/autocmds.lua`:

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.colorcolumn = "100"
  end,
  desc = "Go-specific settings",
})
```

**Effect**: 100-character line guide for Go files only.

### Custom Telescope Pickers

Create project-specific finders:

```lua
-- In lua/config/keymaps.lua
vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").find_files({
    cwd = "internal/handlers",
    prompt_title = "Find Handlers",
  })
end, { desc = "Find Handlers" })
```

**Result**: `<leader>fh` searches only handlers directory.

### Snippets

LazyVim includes LuaSnip. Create custom snippets in `~/.config/nvim/snippets/go.lua`:

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("handler", {
    t("func (h *"),
    i(1, "Handler"),
    t(") "),
    i(2, "MethodName"),
    t("(c echo.Context) error {"),
    t({"", "\treturn c.JSON(http.StatusOK, "}),
    i(3, "response"),
    t(")"),
    t({"", "}"}),
  }),
}
```

**Usage**: Type `handler` → Tab → expands to full handler template.

### Session Management

Neovim sessions save window layouts and open files:

**Save Session**:
```vim
:mksession! ~/dev/climb-tracker/.session.vim
```

**Load Session**:
```vim
nvim -S ~/dev/climb-tracker/.session.vim
```

**Auto-Load**: Add to `init.lua`:
```lua
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("source .session.vim")
    end
  end,
})
```

### Terminal Automation

Send commands to terminals programmatically:

```lua
-- Send "make build" to terminal
local term_chan = vim.api.nvim_open_term(bufnr, {})
vim.api.nvim_chan_send(term_chan, "make build\n")
```

**Use Case**: Build shortcut that sends command to existing terminal.

### Custom Commands

Define commands in `lua/config/autocmds.lua`:

```lua
vim.api.nvim_create_user_command("BuildTempl", function()
  vim.cmd("terminal make build-templ")
end, { desc = "Build templ templates" })
```

**Usage**: `:BuildTempl` runs `make build-templ` in terminal.

---

## Chapter 15: Troubleshooting

### Common Issues and Solutions

**LSP Not Starting**

Symptoms: No completion, no errors, no hover

Diagnosis:
1. `:LspInfo` → check if server attached
2. `:Mason` → verify server installed
3. `:LspLog` → check for errors

Solutions:
- Install server: `:Mason` → search → press `i`
- Restart LSP: `:LspRestart`
- Check health: `:checkhealth nvim-lspconfig`

**Slow Startup**

Symptoms: Neovim takes >200ms to start

Diagnosis:
- `:Lazy profile` → see plugin load times
- Check for synchronous plugin loading

Solutions:
- Add `lazy = true` to plugins
- Use `cmd`, `ft`, `event` to defer loading
- Disable unused plugins

**Completion Not Working**

Symptoms: No suggestions when typing

Diagnosis:
1. `:LspInfo` → ensure LSP running
2. Check filetype: `:set ft?`
3. Verify nvim-cmp loaded: `:Lazy`

Solutions:
- Correct filetype detection
- Restart LSP: `:LspRestart`
- Check completion sources config

**Formatting Not Applied**

Symptoms: File doesn't format on save

Diagnosis:
1. `:ConformInfo` → check active formatters
2. Verify formatter installed: `:Mason`
3. Check file type recognized

Solutions:
- Install formatter via Mason
- Enable format-on-save in conform settings
- Manually format: `<leader>cf`

**Git Blame Not Showing**

Symptoms: No inline blame appears

Diagnosis:
- Check gitsigns loaded: `:Lazy`
- Verify file is in git repository

Solutions:
- Ensure in git repo: `git status`
- Check gitsigns config in `git.lua`
- Toggle blame: `<leader>gB`

**Terminal Not Opening**

Symptoms: `<leader>ft` does nothing

Diagnosis:
- Check keybinding exists: `:map <leader>ft`
- Check terminal plugin loaded

Solutions:
- LazyVim includes terminal by default
- Try `:terminal` manually
- Check for keybinding conflicts

**Neo-tree Not Toggling**

Symptoms: `<leader>e` doesn't open Neo-tree

Diagnosis:
- Check custom keymap in `keymaps.lua`
- Verify Neo-tree plugin loaded: `:Lazy`

Solutions:
- Manually open: `:Neotree`
- Check for errors in keymap function
- Restart Neovim

**Database UI Not Connecting**

Symptoms: `:DBUIToggle` shows no databases

Diagnosis:
- Check connection string configured
- Verify PostgreSQL running: `docker ps`

Solutions:
- Add connection in dadbod config
- Test connection: `psql` in terminal
- Check port 5433 (not default 5432)

### Performance Optimization

**Reduce Treesitter Highlights**:
```lua
-- In a plugin file
{
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  },
}
```

**Disable Unused Extras**:
- `:LazyExtras` → disable unused language extras
- Reduces startup time

**Lazy Load More Aggressively**:
```lua
-- Load only on command
{ "plugin/name", cmd = "PluginCommand" }

-- Load only for filetype
{ "plugin/name", ft = "go" }
```

### Debugging Your Configuration

**Check Load Order**:
```vim
:messages  " View startup messages
:Lazy     " Check plugin status
```

**Test Minimal Config**:
```bash
nvim --clean  # Start without any configuration
```

If issue disappears, problem is in your config.

**Binary Search Plugins**:
1. Disable half your plugins
2. Restart, test if issue persists
3. If persists, problem in active half
4. Repeat until isolated

**Check Health**:
```vim
:checkhealth              " All health checks
:checkhealth nvim-lspconfig
:checkhealth lazy
```

### Getting Help

**Built-in Help**:
```vim
:help lsp
:help telescope
:help lazy.nvim
```

**LazyVim Documentation**:
- Website: lazyvim.org
- GitHub: github.com/LazyVim/LazyVim

**Plugin Documentation**:
- `:Lazy` → select plugin → press `?` for help

**Community Resources**:
- Neovim Reddit: r/neovim
- Neovim Discord
- GitHub issues for specific plugins

### Configuration Validation

Periodically verify configuration health:

1. **Health Check**: `:checkhealth` → review warnings
2. **Plugin Update**: `:Lazy update` → keep plugins current
3. **LSP Status**: `:LspInfo` in each filetype
4. **Mason Status**: `:Mason` → ensure tools installed
5. **Treesitter Status**: `:TSModuleInfo` → verify parsers installed

### Rollback Strategy

If update breaks something:

**Plugin Rollback**:
1. `:Lazy` → select broken plugin
2. Press `x` to show commit history
3. Select older commit
4. Press `<CR>` to rollback

**Configuration Rollback**:
```bash
cd ~/.config/nvim
git log  # Find working commit
git checkout <commit-hash> lua/plugins/broken-plugin.lua
```

**Full Restore**:
Keep `lazy-lock.json` in git. Checkout previous commit to restore all plugin versions.

---


## Appendix A: VSCode to Neovim Mapping

### File Navigation

| VSCode | Neovim | Description |
|--------|--------|-------------|
| Ctrl+P | `<leader>ff` | Find files |
| Ctrl+Shift+F | `<leader>fg` | Search in files |
| Ctrl+Tab | `<S-h>` / `<S-l>` | Switch buffers |
| Ctrl+\ | `<leader>w-` or `<leader>w|` | Split editor |
| Ctrl+W | `<leader>bd` | Close file |
| Ctrl+B | `<leader>e` | Toggle sidebar |

### Editing

| VSCode | Neovim | Description |
|--------|--------|-------------|
| Ctrl+D | `*` then `cgn` | Multi-cursor effect |
| Ctrl+/ | `gcc` | Comment line |
| Alt+Up/Down | `:m +1` / `:m -2` | Move line |
| Ctrl+] | `gd` | Go to definition |
| Shift+F12 | `gr` | Find references |
| F2 | `<leader>cr` | Rename symbol |
| Ctrl+Space | `<C-Space>` | Trigger completion |
| Ctrl+. | `<leader>ca` | Code actions |

### Terminal

| VSCode | Neovim | Description |
|--------|--------|-------------|
| Ctrl+` | `<leader>ft` | Toggle terminal |
| Ctrl+Shift+` | `:terminal` | New terminal |

### Git

| VSCode | Neovim | Description |
|--------|--------|-------------|
| Source Control view | `<leader>gg` | Git UI (lazygit) |
| GitLens blame | Automatic | Inline blame (500ms delay) |
| View changes | `<leader>ghp` | Preview hunk |

### Debugging

| VSCode | Neovim | Description |
|--------|--------|-------------|
| F9 | `<leader>db` | Toggle breakpoint |
| F5 | `<leader>dc` | Start debugging |
| F10 | `<leader>do` | Step over |
| F11 | `<leader>di` | Step into |

### Workflow

| VSCode | Neovim | Description |
|--------|--------|-------------|
| Problems panel | `<leader>xx` | Diagnostics list |
| Go to Line (Ctrl+G) | `:15` or `15G` | Jump to line 15 |
| Command Palette | `:` | Command mode |
| Search (Ctrl+F) | `/pattern` | In-file search |
| Replace (Ctrl+H) | `:%s/old/new/g` | Replace in file |

---

## Appendix B: Your Configuration Files

### Directory Structure Reference

```
~/.config/nvim/
├── init.lua                    # Bootstrap LazyVim
├── lua/
│   ├── config/
│   │   ├── autocmds.lua       # Auto-save on focus loss
│   │   ├── keymaps.lua        # Neo-tree toggle/focus
│   │   ├── lazy.lua           # lazy.nvim setup
│   │   └── options.lua        # Tabs, line numbers
│   └── plugins/
│       ├── dap.lua            # Debugging (optional)
│       ├── docker.lua         # Dockerfile syntax
│       ├── git.lua            # Inline git blame
│       ├── go.lua             # Go development (lang.go extra)
│       ├── htmx.lua           # HTMX support
│       ├── make.lua           # Makefile syntax
│       ├── octo.lua           # GitHub PRs
│       ├── playwright.lua     # Test runner (optional)
│       ├── sql.lua            # PostgreSQL access
│       ├── tailwind.lua       # Tailwind CSS (lang.tailwindcss extra)
│       ├── templ.lua          # templ templates
│       └── typescript.lua     # TypeScript (lang.typescript extra)
├── lazy-lock.json             # Plugin versions (commit to git)
├── lazyvim.json               # LazyVim state
├── README.md                  # Plugin rationale
├── REFERENCE.md               # Keybinding quick reference
└── .ai-context.md             # AI collaboration context
```

### Key Configuration Snippets

**Auto-Save (`autocmds.lua`)**:
```lua
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wa",
  desc = "Auto-save all buffers on focus loss or buffer leave",
})
```

**Go Tab Settings (`options.lua`)**:
```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
```

**Neo-tree Smart Toggle (`keymaps.lua`)**:
```lua
vim.keymap.set("n", "<leader>e", function()
  local neotree_bufnr = vim.fn.bufnr("neo-tree")
  local neotree_window = vim.fn.win_findbuf(neotree_bufnr)
  if #neotree_window == 1 and vim.fn.winnr() ~= neotree_window then
    vim.fn.win_gotoid(neotree_window[1])
  else
    vim.cmd("Neotree toggle")
  end
end, { desc = "Toggle or focus Neo-tree" })
```

**Go Language Support (`go.lua`)**:
```lua
return {
  { import = "lazyvim.plugins.extras.lang.go" },
}
```

**Git Inline Blame (`git.lua`)**:
```lua
{
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
  },
}
```

---

## Appendix C: Essential Commands Reference

### File Operations

```vim
:w                    " Save current file
:wa                   " Save all files
:q                    " Quit current window
:qa                   " Quit all windows
:wq                   " Save and quit
:e filename           " Edit (open) file
:e .                  " Open file browser
```

### Buffer Management

```vim
:ls                   " List buffers
:b N                  " Switch to buffer N
:bd                   " Delete current buffer
:bn                   " Next buffer
:bp                   " Previous buffer
```

### Window Management

```vim
:split                " Horizontal split
:vsplit               " Vertical split
<C-w>h/j/k/l         " Navigate windows
<C-w>c               " Close window
<C-w>o               " Close all except current
<C-w>=               " Equalize window sizes
```

### LSP Commands

```vim
:LspInfo              " Show LSP status
:LspRestart           " Restart LSP servers
:LspLog               " View LSP logs
:Mason                " Open Mason (LSP installer)
:ConformInfo          " Check formatter status
```

### Plugin Management

```vim
:Lazy                 " Open plugin manager
:Lazy update          " Update all plugins
:Lazy sync            " Install/update/clean plugins
:Lazy clean           " Remove unused plugins
:Lazy profile         " Show load times
:LazyExtras           " Browse LazyVim extras
```

### Git Commands

```vim
:Git <cmd>            " Run git command
:Git blame            " Show git blame
:Gitsigns preview_hunk " Preview current hunk
:Gitsigns stage_hunk  " Stage current hunk
:Gitsigns reset_hunk  " Reset current hunk
```

### Database Commands

```vim
:DBUI                 " Open database UI
:DBUIToggle           " Toggle database UI
:DBUIAddConnection    " Add database connection
:DBUIFindBuffer       " Find database buffer
```

### GitHub Commands

```vim
:Octo pr list         " List pull requests
:Octo pr view         " View current PR
:Octo pr comments     " View PR comments
:Octo pr create       " Create new PR
:Octo pr ready        " Mark PR as ready
```

### Debugging Commands

```vim
:DapContinue          " Start/continue debugging
:DapToggleBreakpoint  " Toggle breakpoint
:DapStepOver          " Step over line
:DapStepInto          " Step into function
:DapStepOut           " Step out of function
:DapTerminate         " Stop debugging
```

### Terminal Commands

```vim
:terminal             " Open terminal in current window
:split | terminal     " Open terminal in horizontal split
:vsplit | terminal    " Open terminal in vertical split
```

### Treesitter Commands

```vim
:TSInstall <lang>     " Install language parser
:TSUpdate             " Update all parsers
:TSModuleInfo         " Show module status
```

### Diagnostic Commands

```vim
:Telescope diagnostics " Open diagnostics picker
:lua vim.diagnostic.open_float() " Show line diagnostics
:lua vim.diagnostic.setloclist() " Send diagnostics to location list
```

### Search Commands

```vim
/pattern              " Search forward
?pattern              " Search backward
:noh                  " Clear search highlight
:%s/old/new/g         " Replace all in file
:%s/old/new/gc        " Replace with confirmation
:g/pattern/d          " Delete lines matching pattern
```

### Help Commands

```vim
:help <topic>         " Open help for topic
:help lsp             " LSP documentation
:help telescope       " Telescope help
:help lazy.nvim       " lazy.nvim help
:checkhealth          " Run health checks
```

---

## Index

**A**
- Auto-save configuration, Ch. 10
- Autocmds (automatic commands), Ch. 10
- Asynchronous operations, Ch. 1

**B**
- Buffer management, Ch. 6
- Buffer navigation, Ch. 9, App. C
- Bufferline plugin, Ch. 6
- Build system integration, Ch. 12

**C**
- Code actions, Ch. 5
- Command-line mode, Ch. 2
- Completion system, Ch. 5
- Configuration files, App. B
- Custom keybindings, Ch. 14

**D**
- DAP (Debug Adapter Protocol), Ch. 10, Ch. 11
- Database interaction, Ch. 11, Ch. 12
- Debugging, Ch. 11, Ch. 14, App. A
- Diagnostics, Ch. 5, Ch. 7
- Docker support, Ch. 10, Ch. 11

**E**
- Error detection (LSP), Ch. 5

**F**
- File navigation, Ch. 9
- Formatting, Ch. 5, Ch. 11
- Fuzzy finding, Ch. 9

**G**
- Git integration, Ch. 10, Ch. 12
- GitHub PRs (octo.nvim), Ch. 10, Ch. 12
- Gitsigns, Ch. 4, Ch. 10
- Go development, Ch. 10, Ch. 11
- gopls LSP, Ch. 5, Ch. 11

**H**
- Hidden buffers, Ch. 6
- Hover information, Ch. 5
- HTMX support, Ch. 10, Ch. 11

**I**
- Insert mode, Ch. 2
- init.lua, Ch. 10

**J**
- Jump list, Ch. 9

**K**
- Keybindings, Ch. 10, App. A, App. C

**L**
- Language Server Protocol (LSP), Ch. 5
- lazy.nvim, Ch. 3, Ch. 10
- LazyVim architecture, Ch. 3
- LazyVim extras, Ch. 3, Ch. 10
- lazygit, Ch. 4, Ch. 12
- Location list, Ch. 7
- LSP configuration, Ch. 5, Ch. 11, Ch. 14
- Lua scripting, Ch. 1

**M**
- Macros, Ch. 14
- Makefile support, Ch. 10, Ch. 11
- Marks, Ch. 9
- Mason (LSP installer), Ch. 5
- Modal editing, Ch. 2

**N**
- Neo-tree, Ch. 4, Ch. 9
- Neovim architecture, Ch. 1
- Normal mode, Ch. 2

**O**
- octo.nvim (GitHub integration), Ch. 4, Ch. 10
- Options configuration, Ch. 10

**P**
- Plugin ecosystem, Ch. 4
- Plugin management, Ch. 4, App. C
- Playwright testing, Ch. 10, Ch. 11
- PostgreSQL (vim-dadbod), Ch. 4, Ch. 10

**Q**
- Quickfix list, Ch. 7

**R**
- Refactoring workflow, Ch. 12, Ch. 13

**S**
- Search and replace, Ch. 9, Ch. 12, Ch. 14
- Session management, Ch. 14
- Splits (window splits), Ch. 6
- SQL development, Ch. 11

**T**
- Tabs (Neovim tabs), Ch. 6
- Tailwind CSS support, Ch. 10, Ch. 11
- Telescope fuzzy finder, Ch. 4, Ch. 9
- templ template language, Ch. 10, Ch. 11
- Terminal emulator, Ch. 8
- Terminal workflow, Ch. 12
- Text objects, Ch. 2
- Treesitter, Ch. 4
- Troubleshooting, Ch. 15
- TypeScript support, Ch. 10, Ch. 11

**V**
- vim-dadbod (database), Ch. 4, Ch. 10, Ch. 11
- Visual mode, Ch. 2
- VSCode comparison, Ch. 1, App. A

**W**
- Window management, Ch. 6, App. C
- Workflow integration, Ch. 12

---

**End of Guide**

---

*This guide is tailored to your LazyVim configuration at `~/.config/nvim/` and the climb-tracker project at `~/dev/climb-tracker/`. For questions specific to your setup, reference:*

- *`~/.config/nvim/README.md` - Plugin rationale*
- *`~/.config/nvim/REFERENCE.md` - Quick keybinding reference*  
- *`~/.config/nvim/.ai-context.md` - Configuration context*

*For general Neovim documentation: `:help` or visit neovim.io*

*For LazyVim documentation: lazyvim.org*

