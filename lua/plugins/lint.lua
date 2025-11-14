-- Linting Configuration (nvim-lint)
--
-- Why: Provides real-time linting feedback for code quality issues.
-- For Go projects, uses golangci-lint which runs multiple linters in parallel
-- and is the industry standard for Go linting.
--
-- golangci-lint includes:
--   - govet: Official Go static analyzer
--   - errcheck: Checks for unchecked errors
--   - staticcheck: Advanced static analysis
--   - gosimple: Suggests code simplifications
--   - unused: Finds unused code
--   - And many more configurable linters
--
-- Note: This config extends LazyVim's Go extras which already sets up
-- golangci-lint. This file makes the configuration explicit and allows
-- for customization.
--
-- Usage:
--   - Linting runs automatically on save and text changes
--   - Check linter status: :LintInfo (if available)
--   - golangci-lint respects .golangci.yml in your project root

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
    },
  },
}
