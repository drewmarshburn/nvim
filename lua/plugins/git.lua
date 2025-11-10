-- Enhanced Git Integration
--
-- Why: climb-tracker follows a strict PR-based workflow with frequent commits.
-- This plugin enhances the built-in git support:
--   - Inline git blame: See who changed each line and when
--   - Change indicators: Visual markers for added/modified/deleted lines
--   - Quick hunk navigation: Jump between changes easily
--   - Stage hunks: Stage individual changes without leaving editor
--
-- Workflow benefits:
--   - Track changes during PR reviews
--   - Understand code history while reading
--   - Quick context on "why" a line exists (via commit message)
--   - Efficient staging of partial changes
--
-- Complements existing tools:
--   - lazygit (already in LazyVim): For complex git operations
--   - octo.nvim (already configured): For GitHub PR management
--   - gh CLI (system): For terminal-based GitHub operations

return {
  -- gitsigns: LazyVim includes this by default, but we enhance the config
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Show git blame info inline after cursor line
      current_line_blame = true,
      
      -- Delay before showing blame (milliseconds)
      -- Prevents flickering while moving cursor
      current_line_blame_opts = {
        delay = 500,
        virt_text = true,
        virt_text_pos = "eol", -- Show at end of line
      },
      
      -- Format of the blame text
      -- Example: "Drew Marshburn • 2 hours ago • fix: handle empty workout list"
      current_line_blame_formatter = '<author> • <author_time:%R> • <summary>',
      
      -- Sign column indicators for changes
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },
}
