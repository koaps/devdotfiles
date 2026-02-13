vim.pack.add({
  { src = "https://github.com/edeneast/nightfox.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
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
