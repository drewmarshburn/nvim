-- Formatter Configuration (conform.nvim)
--
-- Why: Extends LazyVim's default conform.nvim configuration to add JSON formatting.
-- Uses Prettier for JSON files to maintain consistent formatting across the project.
--
-- conform.nvim is LazyVim's default formatter plugin. This spec overrides
-- the default configuration to add filetype-specific formatters.
--
-- Usage:
--   - Format on save (if enabled in LazyVim)
--   - Manual format: <leader>cf (LazyVim default keybinding)
--   - Check formatter status: :ConformInfo

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Add Prettier as the JSON formatter
      json = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
