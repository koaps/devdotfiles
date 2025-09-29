-- BOOTSTRAP the plugin manager `lazy.nvim` https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyLocallyAvailable = vim.uv.fs_stat(lazypath) ~= nil
if not lazyLocallyAvailable then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }):wait()
    if out.code ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
--- Custom Options / Keymaps
--------------------------------------------------------------------------------

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- escape mode in the terminal
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")
vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>")

-- remapping for using navigation keys
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- minimize terminal split
vim.keymap.set('n', '<C-g>', "3<C-w>_")

-- tabs
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
  group = highlight_group,
  pattern = '*',
})


--------------------------------------------------------------------------------
--- Plugins Config
--------------------------------------------------------------------------------

local plugins = {

    -----------------------------------------------------------------------------
    --  SNACKS - load early
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        dashboard = {
          preset = {
            pick = function(cmd, opts)
              return LazyVim.pick(cmd, opts)()
            end,
          },
          sections = {
            { section = "header" },
            {
              pane = 2,
              section = "terminal",
              cmd = "echo '₍ᐢ•(ܫ)•ᐢ₎'",
              height = 5,
              padding = 1,
            },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          }, 
        },
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        quickfile = { enabled = true },
      },
    },

    -- TOOLING: COMPLETION, DIAGNOSTICS, FORMATTING

    -- MASON
    -- * Manager for external tools (LSPs, linters, debuggers, formatters)
    -- * auto-install those external tools
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            { "williamboman/mason.nvim", opts = true },
            { "williamboman/mason-lspconfig.nvim", opts = true },
        },
        opts = {
            ensure_installed = {
                -- "pyright", -- LSP for python
                -- "ruff", -- linter & formatter (includes flake8, pep8, black, isort, etc.)
                -- "debugpy", -- debugger
                "taplo", -- LSP for toml (e.g., for pyproject.toml files)
            },
        },
    },

    -- Setup the LSPs
    -- `gd` and `gr` for goto definition / references
    -- `<C-f>` for formatting
    -- `<leader>c` for code actions (organize imports, etc.)
    {
        "neovim/nvim-lspconfig",
        keys = {
            { "lr", vim.lsp.buf.rename, desc = "Rename" },
            { "lrs", vim.lsp.buf.definition, desc = "Rename Symbol" },
            { "lgd", vim.lsp.buf.definition, desc = "Goto Definition" },
            { "lgr", vim.lsp.buf.references, desc = "Goto References" },
            { "<leader>lca", vim.lsp.buf.code_action, desc = "Code Action" },
            { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", desc = "Format" },
            { "<leader>lcl", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "Codelens Action" },
            { "<leader>lff", vim.lsp.buf.format, desc = "File Format" },
            { "lhd", vim.lsp.buf.hover, desc = "Hover Documentation" },
        },
        init = function()
            -- this snippet enables auto-completion
            local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
            lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

            -- setup pyright with completion capabilities
            require("lspconfig").pyright.setup({
                capabilities = lspCapabilities,
                settings = {
                  pyright = {
                  -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                  },
                python = {
                  analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { '*' },
                  },
                },
              },
            })

            -- setup taplo with completion capabilities
            require("lspconfig").taplo.setup({
                capabilities = lspCapabilities,
            })

            -- ruff uses an LSP proxy, therefore it needs to be enabled as if it
            -- were a LSP. In practice, ruff only provides linter-like diagnostics
            -- and some code actions, and is not a full LSP yet.
            require("lspconfig").ruff.setup({
                  init_options = {
                    settings = {
                      lint = {
                        preview = true,
                        select = {"E4", "E7", "E9", "F", "B"},
                        ignore = {"E501"},
                        unfixable = {"B"},
                      }
                    }
                  }
                -- disable ruff as hover provider to avoid conflicts with pyright
                -- on_attach = function(client) client.server_capabilities.hoverProvider = false end,
            })
        end,
    },

    -- COMPLETION
    {
        "saghen/blink.cmp",
        version = "v1.1.*", -- blink.cmp requires a release tag for its rust binary

        opts = {
            -- 'default' for mappings similar to built-in vim completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            keymap = { preset = "super-tab" },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'normal'
                -- nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },

    -- AUTO PAIRING
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    -- SNIPPETS
    { "rafamadriz/friendly-snippets" },

    {
	    "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },

	    -- follow latest release.
	    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	    -- install jsregexp (optional!).
	    build = "make install_jsregexp",
    	    init = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })
            	-- Note: It's mandatory to have a 'package.json' file in the snippet directory.
	    end,
    },

    -- TROUBLE
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },


    -----------------------------------------------------------------------------
    -- PYTHON REPL
    -- A basic REPL that opens up as a horizontal split
    -- * use `<leader>i` to toggle the REPL
    -- * use `<leader>I` to restart the REPL
    -- * `+` serves as the "send to REPL" operator. That means we can use `++`
    -- to send the current line to the REPL, and `+j` to send the current and the
    -- following line to the REPL, like we would do with other vim operators.
    {
        "Vigemus/iron.nvim",
        keys = {
            { "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
            { "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },

            -- these keymaps need no right-hand-side, since that is defined by the
            -- plugin config further below
            { "+", mode = { "n", "x" }, desc = "󱠤 Send-to-REPL Operator" },
            { "++", desc = "󱠤 Send Line to REPL" },
        },

        -- since irons's setup call is `require("iron.core").setup`, instead of
        -- `require("iron").setup` like other plugins would do, we need to tell
        -- lazy.nvim which module to via the `main` key
        main = "iron.core",

        opts = {
            keymaps = {
                send_line = "++",
                visual_send = "+",
                send_motion = "+",
            },
            config = {
                -- This defines how the repl is opened. Here, we set the REPL window
                -- to open in a horizontal split to the bottom, with a height of 10.
                repl_open_cmd = "horizontal bot 10 split",

                -- This defines which binary to use for the REPL. If `ipython` is
                -- available, it will use `ipython`, otherwise it will use `python3`.
                -- since the python repl does not play well with indents, it's
                -- preferable to use `ipython` or `bypython` here.
                -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
                repl_definition = {
                    python = {
                        command = function()
                            local ipythonAvailable = vim.fn.executable("ipython") == 1
                            local binary = ipythonAvailable and "ipython" or "python3"
                            return { binary }
                        end,
                    },
                },
            },
        },
    },

    -----------------------------------------------------------------------------
    -- SYNTAX HIGHLIGHTING & COLORSCHEME

    -- treesitter for syntax highlighting
    -- * auto-installs the parser for python
    {
        "nvim-treesitter/nvim-treesitter",
        -- automatically update the parsers with every new release of treesitter
        build = ":TSUpdate",

        -- since treesitter's setup call is `require("nvim-treesitter.configs").setup`,
        -- instead of `require("nvim-treesitter").setup` like other plugins do, we
        -- need to tell lazy.nvim which module to via the `main` key
        main = "nvim-treesitter.configs",

        opts = {
            highlight = { enable = true }, -- enable treesitter syntax highlighting
            indent = { enable = true }, -- better indentation behavior
            ensure_installed = {
                -- auto-install the Treesitter parser for python and related languages
                "python",
                "toml",
                "rst",
                "ninja",
                "markdown",
                "markdown_inline",
            },
        },
    },

    -- Provides icons (glyphs)
    {
        "nvim-tree/nvim-web-devicons",
        "echasnovski/mini.nvim",
        version = false,
        init = function()
            require'mini.icons'.setup()
        end
    },

    -- statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'echasnovski/mini.icons' },
        config = function()
            -- mini.icons
            require("mini.icons").setup()

            -- mock nvim-web-devicons to use mini.icons instead
            require("mini.icons").mock_nvim_web_devicons()


            require("lualine").setup({
                icons_enabled = true,
                theme = "nightfox",
                section_separators = '',
                component_separators = '',
            })
        end,
    },

    -- COLORSCHEME
    -- In neovim, the choice of color schemes is unfortunately not purely
    -- aesthetic – treesitter-based highlighting or newer features like semantic
    -- highlighting are not always supported by a color scheme. It's therefore
    -- recommended to use one of the popular, and actively maintained ones to get
    -- the best syntax highlighting experience:
    -- https://dotfyle.com/neovim/colorscheme/top
    { "folke/tokyonight.nvim", name = "tokyonight", priority = 1000 },
    { "savq/melange-nvim", name = "melange", priority = 1001 },
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1002 },

    -- blankline
    {
      "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        init = function()
          require('lualine').setup()
          options = { theme = 'codedark' }
        end,
    },

    -----------------------------------------------------------------------------
    -- FUZZY FINDING
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- FILE TREE
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },

    -----------------------------------------------------------------------------
    -- DEBUGGING

    -- DAP Client for nvim
    -- * start the debugger with `<leader>dc`
    -- * add breakpoints with `<leader>db`
    -- * terminate the debugger `<leader>dt`
    {
        "mfussenegger/nvim-dap",
        keys = {
            {
                "<leader>dc",
                function() require("dap").continue() end,
                desc = "Start/Continue Debugger",
            },
            {
                "<leader>db",
                function() require("dap").toggle_breakpoint() end,
                desc = "Add Breakpoint",
            },
            {
                "<leader>dt",
                function() require("dap").terminate() end,
                desc = "Terminate Debugger",
            },
        },
    },

    -- UI for the debugger
    -- * the debugger UI is also automatically opened when starting/stopping the debugger
    -- * toggle debugger UI manually with `<leader>du`
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            {
                "<leader>du",
                function() require("dapui").toggle() end,
                desc = "Toggle Debugger UI",
            },
        },
        -- automatically open/close the DAP UI when starting/stopping the debugger
        config = function()
            local listener = require("dap").listeners
            listener.after.event_initialized["dapui_config"] = function() require("dapui").open() end
            listener.before.event_terminated["dapui_config"] = function() require("dapui").close() end
            listener.before.event_exited["dapui_config"] = function() require("dapui").close() end
        end,
    },

    -- Configuration for the python debugger
    -- * configures debugpy for us
    -- * uses the debugpy installation from mason
    -- {
    --    "mfussenegger/nvim-dap-python",
    --    dependencies = "mfussenegger/nvim-dap",
    --    config = function()
            -- fix: E5108: Error executing lua .../Local/nvim-data/lazy/nvim-dap-ui/lua/dapui/controls.lua:14: attempt to index local 'element' (a nil value)
            -- see: https://github.com/rcarriga/nvim-dap-ui/issues/279#issuecomment-1596258077
     --       require("dapui").setup()
            -- uses the debugypy installation by mason
     --       local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path()
     --           .. "/venv/bin/python3"
     --       require("dap-python").setup(debugpyPythonPath, {}) ---@diagnostic disable-line: missing-fields
     --   end,
    --},

    -----------------------------------------------------------------------------
    -- EDITING SUPPORT PLUGINS
    -- some plugins that help with python-specific editing operations

    -- Docstring creation
    -- * quickly create docstrings via `<leader>a`
    {
        "danymat/neogen",
        opts = true,
        keys = {
            {
                "<leader>a",
                function() require("neogen").generate() end,
                desc = "Add Docstring",
            },
        },
    },

    -- f-strings
    -- * auto-convert strings to f-strings when typing `{}` in a string
    -- * also auto-converts f-strings back to regular strings when removing `{}`
    {
        "chrisgrieser/nvim-puppeteer",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -----------------------------------------------------------------------------
    -- TMUX SUPPORT PLUGINS
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },

    -----------------------------------------------------------------------------
    -- OLLAMA SUPPORT PLUGINS
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      init = function()
        require("codecompanion").setup({
          adapters = {
            ollama = function()
              return require("codecompanion.adapters").extend("ollama", {
                env = {
                  url = "http://192.168.0.254:"
                },
                headers = {
                  ["Content-Type"] = "application/json"
                },
                name = "NAI-PP-3B",
                parameters = {
                  sync = true
                },
                schema = {
                  model = {
                    default = "0xroyce/NazareAI-Python-Programmer-3B"
                  },
                  temperature = 0.3,
                }
              })
            end
          },
        })
      end,
    },

    -----------------------------------------------------------------------------
    -- WHICH KEY
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },

     -----------------------------------------------------------------------------
     -- DASHBOARD
--    {
--      'nvimdev/dashboard-nvim',
--      event = 'VimEnter',
--      config = function()
--            require('dashboard').setup {
--          -- config
--        }
--      end,
--      dependencies = { {'nvim-tree/nvim-web-devicons'}}
--    },



}  -- END ----------------------------------------------------------------------

--------------------------------------------------------------------------------

-- tell lazy.nvim to load and configure all the plugins
require("lazy").setup(plugins)

-- default color
vim.cmd.colorscheme("moonfly")

-- snippets maps
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- telescope maps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })



--------------------------------------------------------------------------------
-- SETUP BASIC PYTHON-RELATED OPTIONS

-- The filetype-autocmd runs a function when opening a file with the filetype
-- "python". This method allows you to make filetype-specific configurations. In
-- there, you have to use `opt_local` instead of `opt` to limit the changes to
-- just that buffer. (As an alternative to using an autocmd, you can also put those
-- configurations into a file `/after/ftplugin/{filetype}.lua` in your
-- nvim-directory.)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python", -- filetype for which to run the autocmd
    callback = function()
        -- use pep8 standards
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4

        -- folds based on indentation https://neovim.io/doc/user/fold.html#fold-indent
        -- if you are a heavy user of folds, consider using `nvim-ufo`
        vim.opt_local.foldmethod = "manual"

        -- enable LSP
        vim.lsp.enable('ruff')

        local iabbrev = function(lhs, rhs) vim.keymap.set("ia", lhs, rhs, { buffer = true }) end
        -- automatically capitalize boolean values. Useful if you come from a
        -- different language, and lowercase them out of habit.
        iabbrev("true", "True")
        iabbrev("false", "False")

        -- we can also fix other habits we might have from other languages
        iabbrev("--", "#")
        iabbrev("null", "None")
        iabbrev("none", "None")
        iabbrev("nil", "None")
        iabbrev("function", "def")
    end,
})

-- Defer to Pyright for some capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = true
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})
