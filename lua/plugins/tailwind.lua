-- Tailwind CSS v4 Support
--
-- Why: climb-tracker uses Tailwind CSS v4 extensively for styling.
-- This plugin provides intelligent Tailwind development features:
--   - Class completion: Auto-complete Tailwind classes as you type
--   - Hover documentation: See CSS output for any Tailwind class
--   - Color previews: Visual indicators for color classes
--   - Variant support: Complete with hover:, focus:, dark:, etc.
--   - Arbitrary value support: Critical for CSS variables like [var(--variable-name)]
--
-- Essential for working with:
--   - Dark TUI-themed UI with blue/green/gray palette
--   - CSS variables in static/css/input.css
--   - Arbitrary values throughout templates
--   - Tailwind v4's new @import syntax
--
-- The LSP reads tailwind.config.js and static/css/input.css to provide
-- context-aware completions specific to the project's custom theme.

-- NOTE: I should manage this via LazyExtras because it is causing import order
-- errors when I start nvim.
return {
  -- Import LazyVim's Tailwind CSS extras bundle
  -- Includes: tailwindcss-language-server, class sorting, and IntelliSense
  -- { import = "lazyvim.plugins.extras.lang.tailwindcss" },
}
