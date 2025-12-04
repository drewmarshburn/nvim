# Neovim Quick Reference

Essential keybindings for climb-tracker development. Assumes basic vim knowledge (hjkl, insert mode, etc.).

## Navigation

`<leader>ff` - Find files by name in project  
`<leader>/` - Search text across all files (live grep)  
`<leader>fb` - Browse and switch between open buffers  
`<leader>fr` - Recently opened files  
`<leader>e` - Toggle file explorer (Neo-tree)  
`<leader><leader>` - Switch to last buffer (quick toggle)
`gx` - Goto URL

## Selection

`vi{` - Select block within the angle bracket "{"

## Window Management

`<C-h>` - Move to left window  
`<C-j>` - Move to window below  
`<C-k>` - Move to window above  
`<C-l>` - Move to right window  
`<leader>w-` - Split window horizontally  
`<leader>wv` - Split window vertically
`<leader>wd` - Close current window  
`<C-Up>` - Increase window height  
`<C-Down>` - Decrease window height  
`<C-Left>` - Decrease window width  
`<C-Right>` - Increase window width

## LSP (Code Intelligence)

`gd` - Go to definition (jump to where function/variable is defined)  
`gr` - Show all references (where this is used)  
`K` - Show documentation hover (type info, function signature)  
`gD` - Go to declaration (Go interfaces, type declarations)  
`gi` - Go to implementation  
`<leader>ca` - Code actions (quick fixes, refactorings)  
`<leader>cr` - Rename symbol across entire project  
`[d` - Previous diagnostic/error  
`]d` - Next diagnostic/error  
`<leader>cd` - Show line diagnostics in float  
`<leader>cl` - Show LSP info for current buffer

## Go Development

`<leader>td` - Run Go test at cursor  
`<leader>tD` - Run all tests in file  
`<leader>ct` - Generate struct tags (json, form, etc.)  
`<leader>ci` - Organize imports (add missing, remove unused)  
`<leader>cf` - Format code (runs gofmt)

## Git Operations

`<leader>gg` - Open lazygit (full git UI)  
`<leader>gb` - Git blame line (show who changed this line)  
`<leader>gB` - Git blame file (toggle blame for all lines)  
`]h` - Next git hunk (changed section)  
`[h` - Previous git hunk  
`<leader>ghs` - Stage hunk (stage just this change)  
`<leader>ghr` - Reset hunk (discard this change)  
`<leader>ghp` - Preview hunk (show diff in float)  
`:Octo pr list` - List GitHub pull requests  
`:Octo pr view` - View current PR in buffer  
`:Octo pr comments` - Show PR comments
`:Octo review start` - Start a PR review
`:Octo review submit` - Submit a PR review with ability to add a final comment
`<C-b>` - Opens PR in browser on Octo list or with PR buffer active

## Search and Replace

`/` - Search forward in file  
`?` - Search backward in file  
`n` - Next search result  
`N` - Previous search result  
`<leader>sR` - Search and replace in files (project-wide)  
`<leader>sr` - Replace in current file  
`*` - Search for word under cursor (forward)  
`#` - Search for word under cursor (backward)

## Code Editing

`gcc` - Toggle comment for current line  
`gc` + motion - Toggle comment (e.g., `gcap` = comment paragraph)  
`<leader>cf` - Format current buffer (runs formatter)  
`<leader>cF` - Format selection  
`J` - Join line below to current line  
`<C-a>` - Increment number under cursor  
`<C-x>` - Decrement number under cursor  
`.` - Repeat last change

## Diagnostics and Quickfix

`<leader>xx` - Toggle diagnostics list (errors/warnings)  
`<leader>xX` - Toggle buffer diagnostics  
`<leader>xq` - Toggle quickfix list  
`]q` - Next quickfix item  
`[q` - Previous quickfix item

## Terminal

`<leader>ft` - Open terminal in floating window  
`<leader>fT` - Open terminal at bottom  
`<C-/>` - Toggle terminal (in terminal mode)  
`<C-\><C-n>` - Exit terminal mode to normal mode

## Database (vim-dadbod)

`:DBUIToggle` - Open database UI  
`:DBUI` - Focus database UI  
`<leader>S` - Execute SQL query (in SQL buffer)  
`o` - Open/expand database/table (in DBUI)  
`R` - Refresh database list (in DBUI)

## Buffers and Tabs

`<S-h>` - Previous buffer  
`<S-l>` - Next buffer  
`<leader>bd` - Delete current buffer  
`<leader>bo` - Delete all buffers except current  
`<leader>bp` - Pin/unpin buffer (prevent accidental close)

## Marks

`ma` - Set a file-local mark "a"
`mA` - Set a global mark "A"
`carat-a` - Jump to mark "a"
`:delm a`  - delete mark "a"
`:marks` - See all marks

## Jump List

`<C-o>` - Jump to last cursor location
`<C-i>` - Jump  to next cursor location

## Debugging (DAP) - Optional

`<leader>db` - Toggle breakpoint on current line  
`<leader>dB` - Set conditional breakpoint  
`<leader>dc` - Continue execution (start/resume debugging)  
`<leader>di` - Step into function  
`<leader>do` - Step over line  
`<leader>dO` - Step out of function  
`<leader>dt` - Terminate debugging session  
`<leader>dr` - Toggle REPL (evaluate expressions)

## Testing (Playwright) - Optional

`<leader>tt` - Run test at cursor  
`<leader>tf` - Run all tests in current file  
`<leader>ts` - Run entire test suite  
`<leader>to` - Show test output panel  
`<leader>tS` - Toggle test summary

## Miscellaneous

`<leader>qq` - Quit all windows  
`<leader>L` - Open LazyVim changelog  
`:Lazy` - Open plugin manager  
`:Mason` - Open LSP/tool installer  
`:LspInfo` - Check LSP server status  
`:LspRestart` - Restart LSP servers  
`:checkhealth` - Run health checks  
`<leader>ur` - Toggle relative line numbers  
`<leader>uw` - Toggle word wrap  
`<leader>ul` - Toggle line numbers  
`<leader>us` - Toggle spelling  

## Leader Key

The `<leader>` key is `<Space>` by default in LazyVim.

## Special Keys

- `<C-x>` = Ctrl+x
- `<S-x>` = Shift+x  
- `<leader>` = Space (by default)
- `<localleader>` = \
- `<CR>` = Enter/Return
- `<Esc>` = Escape

## Tips

1. **Telescope fuzzy finding**: In find files (`<leader>ff`), type parts of filename, use spaces to separate terms
2. **Window navigation**: `<C-hjkl>` is muscle memory - practice moving between windows
3. **LSP hover (K)**: Press twice to jump into hover window and scroll
4. **Git hunks**: Use `]h` and `[h` to review changes before committing
5. **Terminal toggle**: `<C-/>` is your friend for quick terminal access
6. **Format on save**: Enabled by default for Go files (gofmt)
7. **Auto-save**: Enabled on focus loss - changes save when you switch to browser
8. **Search in files**: `<leader>fg` then type, results update live

## Internals

### Overrides

When you create a plugin spec with the same plugin name as a core LazyVim plugin, your opts table
gets merged with the defaults. This lets you extend plugin configs without losing LazyVim's default
configurations.

See `plugins/conform.lua` for an example.

### Plugins

Plugins are installed here: `~/.local/share/nvim/lazy`.

## Project-Specific Workflows

### Editing Go Handler
1. `<leader>ff` → type handler name → Enter
2. `gd` on function to jump to definition
3. `K` to see function documentation
4. `<leader>cr` to rename variable across files
5. `:w` to save (or just switch to browser - auto-save)

### Editing templ Template
1. `<leader>e` to open file tree
2. Navigate to `internal/templates/`
3. Edit HTML/Go code with full syntax highlighting
4. Tailwind class completion works in `class=""` attributes
5. `K` on Go variable to see type info

### Testing Workflow
1. `<leader>gg` to open lazygit
2. Review changes with `]h` and `[h`
3. `<leader>ghs` to stage specific hunks
4. Create commit in lazygit
5. `:Octo pr create` to make PR

### Database Debugging
1. `:DBUIToggle` to open database UI
2. `o` to expand climb_tracker database
3. Navigate to table, press `o` to view data
4. `<leader>S` to execute custom query
5. Check data after running Go service

---

**Keep this reference handy!** Print it or keep it open in a split while learning.
