local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.gopls")(capabilities)
require("servers.jsonls")(capabilities)
require("servers.bashls")(capabilities)
require("servers.dockerls")(capabilities)
require("servers.yamlls")(capabilities)

-- Linters & Formatters
require("servers.efm-langserver")(capabilities)

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "gopls",
  "jsonls",
  "bashls",
  "dockerls",
  "yamlls",
  "efm",
})
