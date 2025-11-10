-- Docker and Docker Compose Support
--
-- Why: climb-tracker uses Docker for local development infrastructure.
-- This plugin provides syntax support for Docker configuration files:
--   - Dockerfile syntax highlighting: Proper coloring for instructions
--   - docker-compose.yml support: YAML syntax with Docker-specific validation
--   - Error detection: Catch syntax errors before running containers
--
-- Essential for editing:
--   - docker-compose.yml: PostgreSQL service configuration (port 5433)
--   - Future Dockerfiles for deployment
--   - Container orchestration configurations
--
-- Makes it easier to modify database settings, add new services,
-- or adjust container configurations without leaving the editor.

return {
  -- Add Dockerfile syntax highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "dockerfile", -- Syntax for Dockerfile
      })
    end,
  },

  -- Add docker-compose LSP support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        docker_compose_language_service = {
          -- Provides validation and completion for docker-compose.yml
          filetypes = { "yaml.docker-compose" },
        },
      },
    },
  },

  -- Ensure docker-compose files are recognized
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.filetype.add({
        filename = {
          ["docker-compose.yml"] = "yaml.docker-compose",
          ["docker-compose.yaml"] = "yaml.docker-compose",
        },
      })
    end,
  },
}
