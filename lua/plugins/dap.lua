-- Go Debugging with DAP (Debug Adapter Protocol)
--
-- Why: Debugging complex business logic is often more efficient than print statements.
-- This plugin provides a full debugging experience:
--   - Set breakpoints: Click or keybind to add breakpoints
--   - Step through code: Step over, into, and out of functions
--   - Inspect variables: See values at runtime
--   - Evaluate expressions: Test code snippets in debug context
--   - Watch expressions: Monitor specific values
--
-- Particularly useful for:
--   - Debugging GORM queries in services (internal/services/)
--   - Tracing request flow through handlers (internal/handlers/)
--   - Understanding complex business logic
--   - Investigating data transformation issues
--
-- Example use case: Set a breakpoint in workout_service.go to see exactly
-- what data is being saved when a workout is created.
--
-- Note: This is an OPTIONAL plugin. If you prefer logging/print debugging,
-- you can safely delete or disable this file.

return {
  -- Import LazyVim's DAP core (includes nvim-dap and UI)
  { import = "lazyvim.plugins.extras.dap.core" },

  -- Add Go-specific debugging support
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- nvim-dap-go: Go debugger integration using delve
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup({
            -- delve configuration
            delve = {
              -- Use the version installed via mise or system
              detached = vim.fn.has("win32") == 0,
            },
          })
        end,
      },
    },
  },

  -- Key bindings (LazyVim provides defaults):
  -- <leader>db - Toggle breakpoint
  -- <leader>dB - Breakpoint with condition
  -- <leader>dc - Continue execution
  -- <leader>dC - Run to cursor
  -- <leader>dg - Go to line (without executing)
  -- <leader>di - Step into function
  -- <leader>do - Step out of function
  -- <leader>dO - Step over line
  -- <leader>dp - Pause execution
  -- <leader>dr - Toggle REPL
  -- <leader>ds - Start/continue debugging
  -- <leader>dt - Terminate debugging
  -- <leader>dw - Toggle UI widgets
}
