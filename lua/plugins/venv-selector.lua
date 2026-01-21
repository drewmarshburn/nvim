return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    search = {
      anaconda_base = {
        command = "fd /python$ /usr/local/Caskroom/miniconda --full-path --color never -E /proc",
        type = "anaconda",
      },
    },
  },
}
