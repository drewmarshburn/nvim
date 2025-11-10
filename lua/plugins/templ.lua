-- templ Template Support
--
-- Why: templ is Go's typed HTML template language used throughout climb-tracker.
-- This plugin provides essential support for working with templ files:
--   - Syntax highlighting: Proper coloring for Go code embedded in HTML
--   - LSP integration: Type checking, completion, and error detection
--   - Formatting: Automatic formatting via templ fmt
--   - Go-to-definition: Jump between template components
--
-- Critical for editing files in internal/templates/:
--   - components/*.templ (climb, workout, camera, plan, report components)
--   - pages/*.templ (workout, plans, reports, admin pages)
--   - layout/base.templ (main layout wrapper)
--
-- The LSP ensures type safety when passing data from handlers to templates,
-- catching errors at edit-time rather than runtime.

return {
  -- Add templ LSP server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        templ = {
          -- templ LSP provides type-aware completion and validation
          -- for Go template files (.templ extension)
        },
      },
    },
  },

  -- Add templ syntax highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "templ", -- HTML-like syntax with embedded Go code
      },
    },
  },

  -- Ensure templ files are recognized
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Register .templ files for proper syntax highlighting
      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })
    end,
  },
}
