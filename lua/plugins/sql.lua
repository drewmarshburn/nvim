-- SQL and PostgreSQL Support
--
-- Why: climb-tracker uses PostgreSQL 15 as its database.
-- This plugin provides direct database access and SQL development tools:
--   - vim-dadbod: Connect to PostgreSQL and execute queries from nvim
--   - vim-dadbod-ui: Visual database browser for tables, schemas, and data
--   - SQL completion: Auto-complete table names, columns, and SQL keywords
--   - sqlls LSP: SQL syntax checking and query validation
--
-- Critical use cases:
--   - Quick schema inspection during development
--   - Testing raw SQL queries before adding to GORM
--   - Debugging data issues without leaving editor
--   - Exploring database state during testing
--
-- Connection: postgresql://climb_tracker_user:climb_tracker_pass@localhost:5433/climb_tracker
-- (Update credentials in the connection string below to match your .env)

return {
  -- vim-dadbod: Core database interaction plugin
  -- vim-dadbod-ui: Visual interface for database operations
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI", -- Open database UI
      "DBUIToggle", -- Toggle database UI
      "DBUIAddConnection", -- Add new connection
      "DBUIFindBuffer", -- Find database buffer
    },
    init = function()
      -- Use Nerd Font icons in database UI
      vim.g.db_ui_use_nerd_fonts = 1
      -- Default database connection for climb-tracker
      -- To add: Use :DBUIAddConnection or set vim.g.dbs in your config
      -- Example:
      -- vim.g.dbs = {
      --   climb_tracker = "postgresql://climb_tracker_user:climb_tracker_pass@localhost:5433/climb_tracker"
      -- }
    end,
  },

  -- SQL LSP for syntax checking and completion
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sqlls = {
          -- Provides SQL syntax validation and intelligent completion
          -- Understands PostgreSQL-specific syntax
        },
      },
    },
  },

  -- SQL syntax highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "sql", -- PostgreSQL and general SQL syntax
      })
    end,
  },
}
