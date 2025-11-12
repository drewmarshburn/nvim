-- blink.cmp is Lazy's default completion plugin

return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- Allow for suggestion selection with ctrl + jk
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
    },
  },
}
