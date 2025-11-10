-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- disables relative numbers
vim.opt.number = true -- enables absolute line numbers

-- Go-specific settings
-- Why: Go convention uses tabs for indentation, not spaces.
-- This ensures code matches gofmt output and follows community standards.
-- Applies globally since this is primarily a Go project.
vim.opt.tabstop = 4      -- Display width of tab character (4 spaces wide)
vim.opt.shiftwidth = 4   -- Width of auto-indentation (4 spaces)
vim.opt.expandtab = false -- Use actual tab characters, not spaces

-- Note: Makefile overrides these settings via FileType autocmd in make.lua
-- to ensure proper tab handling in Makefiles as well.
