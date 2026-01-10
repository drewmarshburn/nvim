-- TypeScript/JavaScript Support for Playwright
--
-- Why: climb-tracker uses Playwright for E2E testing, written in TypeScript.
-- This plugin provides complete TypeScript development support:
--   - tsserver LSP: Type checking, completion, and error detection
--   - ESLint integration: Code quality and style enforcement
--   - Proper import management: Auto-imports and organize imports
--   - Type-aware refactoring: Safe renames and extractions
--
-- Critical for working with:
--   - Playwright tests in tests/e2e/smoke/
--   - Test fixtures in tests/fixtures/
--   - Playwright configuration in playwright.config.ts
--   - Helper functions and test data
--
-- The LSP understands Playwright's API and provides intelligent completions
-- for page objects, locators, and assertions.

-- NOTE: I should manage this via LazyExtras because it is causing import order
-- errors when I start nvim.
return {
  -- Import LazyVim's TypeScript extras bundle
  -- Includes: tsserver, ESLint, prettier, and TypeScript-specific tools
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
}
