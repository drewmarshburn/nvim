return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*", -- Highlight all files
      css = {
        rgb_fn = true, -- Enable rgb() function highlighting
        hsl_fn = true, -- Enable hsl() function highlighting
      },
    })
  end,
}
