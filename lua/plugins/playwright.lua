-- Playwright Test Runner Integration
--
-- Why: Running Playwright tests from the terminal requires context switching.
-- This plugin integrates Playwright tests directly into nvim:
--   - Run tests from editor: Execute individual tests or entire suites
--   - Inline results: See pass/fail status next to test definitions
--   - Jump to failures: Navigate directly to failing assertions
--   - Watch mode: Auto-run tests on file changes
--   - Debug integration: Set breakpoints in tests
--
-- Benefits for climb-tracker E2E testing:
--   - Faster feedback loop during test development
--   - Visual indicators of test health in the editor
--   - Easier debugging of flaky tests
--   - No need to switch to terminal to run `npm run test:e2e`
--
-- Works with tests in:
--   - tests/e2e/smoke/critical-path.spec.ts
--   - Any future Playwright test files
--
-- Note: This is an OPTIONAL plugin. If you prefer running tests in the terminal
-- with `npm run test:e2e`, you can safely delete or disable this file.

return {
  -- neotest: Test runner framework for nvim
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      
      -- Playwright adapter for neotest
      "thenbe/neotest-playwright",
    },
    opts = {
      adapters = {
        ["neotest-playwright"] = {
          options = {
            -- Persist project selection between sessions
            persist_project_selection = true,
            
            -- Automatically discover new tests
            enable_dynamic_test_discovery = true,
            
            -- Use the playwright.config.ts in project root
            -- This ensures proper configuration (browsers, baseURL, etc.)
          },
        },
      },
    },
    config = function(_, opts)
      -- Setup neotest with Playwright adapter
      require("neotest").setup(opts)
    end,
  },

  -- Key bindings for test running:
  -- <leader>tt - Run nearest test (test under cursor)
  -- <leader>tf - Run all tests in current file
  -- <leader>ts - Run entire test suite
  -- <leader>to - Show test output panel
  -- <leader>tS - Toggle test summary
  -- <leader>tw - Toggle watch mode
  
  -- Add keybindings
  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").run.run({ suite = true }) end, desc = "Run test suite" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
      { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "Toggle watch mode" },
    },
  },
}
