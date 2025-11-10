-- Makefile Support
--
-- Why: climb-tracker uses a Makefile as the primary build tool interface.
-- This plugin provides syntax highlighting and basic tooling support:
--   - Syntax highlighting: Proper coloring for targets, variables, and commands
--   - Indentation awareness: Makefiles require tabs, not spaces
--   - Error detection: Catch common Makefile syntax errors
--
-- Essential for editing the project Makefile which includes critical targets:
--   - make dev: Start development server
--   - make build: Build the application
--   - make build-templ: Regenerate templ templates
--   - make build-css: Rebuild Tailwind CSS
--   - make db-up: Start PostgreSQL container
--   - make test: Run test suites
--
-- Proper syntax highlighting makes it easier to maintain and extend
-- the build automation without introducing tab/space issues.

return {
  -- Add Makefile syntax highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "make", -- Makefile syntax
      })
    end,
  },

  -- Ensure Makefiles use tabs (required by Make)
  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Create autocmd for Makefile-specific settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "make",
        callback = function()
          -- Makefiles MUST use tabs for indentation
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
        end,
        desc = "Makefile settings (tabs required)",
      })
    end,
  },
}
