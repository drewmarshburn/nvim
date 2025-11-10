return {
  {
    "martineausimon/nvim-lilypond-suite",
    opts = {},
  },
  { "nvim-lua/plenary.nvim", lazy = true }, -- Required for blink.cmp
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-dictionary", -- Required for dictionary completion
    },
    version = "*",
    opts = {
      sources = {
        default = { "dictionary", "lsp", "path", "snippets", "buffer" }, -- Add 'dictionary'
        providers = {
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            max_items = 8,
            opts = {
              dictionary_files = function()
                if vim.bo.filetype == "lilypond" then -- Add lilypond words to sources
                  return vim.fn.glob(vim.fn.expand("$LILYDICTPATH") .. "/*", true, true)
                end
              end,
            },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
