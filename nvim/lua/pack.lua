vim.pack.add({
  { src = "https://github.com/edeneast/nightfox.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
})

require("mini.pick").setup()
require("oil").setup()

local palette = require("nightfox.palette").load("duskfox")
require("nightfox").setup({
  options = {
    transparent = true,
  },
  groups = {
    duskfox = {
      Visual = { bg = palette.bg1 },
    },
  },
})

vim.cmd("colorscheme duskfox")
vim.cmd(":hi statusline guibg=NONE")
