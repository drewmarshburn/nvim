-- HTMX Support
--
-- Why: climb-tracker uses HTMX 1.9 for all frontend interactivity.
-- This plugin enhances HTML editing with HTMX attribute awareness:
--   - HTML syntax highlighting: Via Treesitter
--   - Attribute completion: Auto-complete HTML attributes (via HTML LSP)
--   - Better HTML navigation: Jump between elements
--
-- HTMX attributes used throughout climb-tracker templates:
--   - hx-get, hx-post: Make HTTP requests
--   - hx-target: Specify where to insert response
--   - hx-swap: Control how content is swapped
--   - hx-trigger: Define event triggers
--   - hx-indicator: Show loading states
--
-- While there's no dedicated HTMX LSP, enhanced HTML support provides
-- better attribute completion and makes it easier to work with the
-- complex HTMX-driven UI in internal/templates/components/.

return {
  -- Enhanced HTML syntax via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "html", -- HTML syntax including attributes
      })
    end,
  },

  -- HTML LSP for attribute completion
  -- Note: This provides basic HTML completion including HTMX attributes
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          -- Provides HTML attribute completion
          -- While not HTMX-specific, it completes all data-* and hx-* attributes
          filetypes = { "html", "templ" },
        },
      },
    },
  },

  -- Emmet for HTML expansion (helpful for HTMX templates)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = {
          -- Emmet abbreviations work with HTMX attributes
          -- Example: div[hx-get="/api/data"] expands to full element
          filetypes = { "html", "templ", "css" },
        },
      },
    },
  },
}
