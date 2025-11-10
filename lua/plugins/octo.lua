return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  config = function()
    require("octo").setup({
      default_remote = { "origin" },
      ssh_aliases = {},
      reaction_viewer_hint_icon = "",
      user_icon = " ",
      timeline_marker = "",
      timeline_indent = 2,
      github_hostname = "",
      snippet_context_lines = 4,
      timeout = 5000,
      ui = {
        use_signcolumn = true,
      },
      pull_requests = {
        order_by = {
          field = "CREATED_AT",
          direction = "DESC",
        },
      },
      file_panel = {
        size = 10,
        use_icons = true,
      },
    })
  end,
}
