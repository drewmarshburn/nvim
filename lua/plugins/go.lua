-- Go Development Support
--
-- Why: Provides comprehensive Go development environment for the climb-tracker project:
--   - gopls LSP: Intelligent code completion, go-to-definition, and error checking
--   - gofmt/goimports: Automatic code formatting on save (Go conventions)
--   - go test integration: Run tests directly from editor
--   - Struct tag completion: Essential for GORM models and Echo handlers
--   - Go-specific keybindings: Test running, tag generation, etc.
--
-- This is critical for working with:
--   - Echo v4 handlers in internal/handlers/
--   - GORM models in internal/models/
--   - Business logic in internal/services/
--   - Standard library packages throughout the codebase

-- NOTE: I should manage this via LazyExtras because it is causing import order
-- errors when I start nvim.

return {
  -- Import LazyVim's complete Go extras bundle
  -- Includes: gopls, gofmt, goimports, delve, and go.nvim
  --  { import = "lazyvim.plugins.extras.lang.go" },
}
