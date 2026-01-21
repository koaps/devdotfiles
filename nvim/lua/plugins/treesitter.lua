return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.config")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "dockerfile",
                    "html",
                    "gitignore",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "ninja",
                    "python",
                    "query",
                    "rst",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })

            -- use bash parser for zsh files
            vim.treesitter.language.register("bash", "zsh")
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup()
            vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'fg', bg = 'bg' })
            vim.cmd 'hi TreesitterContextBottom gui=underline'
        end,
    },
}
