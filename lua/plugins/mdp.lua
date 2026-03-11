-- Testing out Donald's markdown preview plugin!

return {
  -- Disable the default markdown previewer
  { "iamcco/markdown-preview.nvim", enabled = false },
  --- Add mdp
  {
    "donaldgifford/mdp",
    -- branch if developing on a branch
    -- branch = "feat/dev"
    keys = {
      { "<localleader>mp", "<cmd>MdpToggle<cr>", desc = "Toggle markdown preview" },
      { "<localleader>mo", "<cmd>MdpOpen<cr>", desc = "Open preview in browser" },
    },
    opts = { theme = "dark" },
  },
}
