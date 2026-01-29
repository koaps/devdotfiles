-- ================================================================================================
-- TITLE : mason-tool-installer
-- ABOUT : Install or upgrade all of your third-party tools.
-- LINKS :
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    { "williamboman/mason.nvim", opts = true },
    { "williamboman/mason-lspconfig.nvim", opts = true },
  },
  opts = {
    ensure_installed = {
      "bash-language-server", -- LSP for bash
      "debugpy", -- debug adapter for python
      "docker-language-server", -- LSP for docker/compose files
      "efm", -- general purpose LSP
      "eslint_d", -- linter for javascript and typescript
      "fixjson", -- JSON formatter
      "gopls", -- LSP for Golang
      "gofumpt", -- formatter for Golang
      "hadolint", -- linter for dockerfiles
      "json-lsp", -- LSP for JSON
      "lua-language-server", -- LSP for Lua
      "luacheck", -- linter for Lua
      "prettierd", -- formatter for CSS, HTML, JSON, ...
      "pyright", -- LSP for python
      "revive", -- linter for Golang
      "ruff", -- linter & formatter (includes flake8, pep8, black, isort, etc.)
      "rust-analyzer", -- LSP for Rust
      "shellcheck", -- linter for Shell scripts
      "shfmt", -- formatter for Shell (bash, mksh, shell)
      "stylua", -- formatter for Lua
      "taplo", -- LSP for toml (e.g., for pyproject.toml files)
      "yaml-language-server", -- LSP for YAML
    },
  },
}
