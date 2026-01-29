-- ================================================================================================
-- TITLE : ruff
-- LINKS :
--   > github: https://github.com/astral-sh/ruff
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil This function doesn't return a value, it configures the LSP server
return function(capabilities)
  -- ruff uses an LSP proxy, therefore it needs to be enabled as if it
  -- were a LSP. In practice, ruff only provides linter-like diagnostics
  -- and some code actions, and is not a full LSP yet.
  vim.lsp.config("ruff", {
    init_options = {
      settings = {
        lint = {
          preview = true,
          select = { "E4", "E7", "E9", "F", "B" },
          ignore = { "E501" },
          unfixable = { "B" },
        },
      },
    },
    -- disable ruff as hover provider to avoid conflicts with pyright
    -- on_attach = function(client) client.server_capabilities.hoverProvider = false end,
  })
end
