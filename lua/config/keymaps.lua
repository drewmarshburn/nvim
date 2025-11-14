-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal: Exit terminal mode with double escape (all terminal buffers)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>e", function()
  -- Check if a Neo-tree buffer already exists
  local neotree_bufnr = vim.fn.bufnr("neo-tree")
  local neotree_window = vim.fn.win_findbuf(neotree_bufnr)

  if #neotree_window == 1 and vim.fn.winnr() ~= neotree_window then
    -- If Neo-tree is open but not focused, focus it
    vim.fn.win_gotoid(neotree_window[1])
  else
    -- Otherwise, open Neo-tree
    vim.cmd("Neotree toggle")
  end
end, { desc = "Toggle or focus Neo-tree" })
