-- Snacks.nvim Configuration
--
-- Why: Snacks.nvim is LazyVim's utility plugin that provides various features
-- including terminal management, bigfile detection, and UI enhancements.
--
-- This configuration adjusts the bigfile threshold to allow working with larger
-- files (up to 10MB) before disabling performance-intensive features like LSP,
-- treesitter, and formatters.
--
-- Default threshold: ~1.5MB
-- Our threshold: 10MB
--
-- This is useful for working with large JSON files, logs, or data files while
-- still maintaining performance protection for truly massive files.

return {
  "folke/snacks.nvim",
  opts = {
    bigfile = {
      enabled = true,
      size = 10 * 1024 * 1024, -- 10MB
    },
  },
}
