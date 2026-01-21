local opt = vim.opt

-- Editor UI
opt.number = true          -- Show line numbers
opt.relativenumber = false -- Relative line numbers for better navigation
opt.signcolumn = 'yes'     -- Always show the sign column
opt.cursorline = true      -- Highlight the current line
opt.colorcolumn = '80'     -- Highlight column 80 for line length indicator
opt.showmode = false       -- Don't show mode (statusline handles it)
opt.termguicolors = true   -- Enable true color support

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- turn off swapfile
opt.swapfile = false

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Editing
opt.autoindent = true   -- copy indent from current line when starting new one
opt.expandtab = true    -- Use spaces instead of tabs
opt.shiftwidth = 4      -- Number of spaces to use for (auto)indent
opt.tabstop = 4         -- Number of spaces per tab
opt.spelllang = 'en_us' -- Set spell check language to US English
opt.spell = true        -- Enable spell check
opt.breakindent = true  -- Maintain indentation when wrapping lines

-- Search
opt.ignorecase = true    -- Case insensitive searching
opt.smartcase = true     -- Case-sensitive if search contains uppercase
opt.hlsearch = true      -- Highlight search matches
opt.inccommand = 'split' -- Live preview of search and replace

-- Window Management
opt.splitbelow = true -- Horizontal splits open below
opt.splitright = true -- Vertical splits open to the right
opt.scrolloff = 999   -- Keep the cursor centered on the screen
opt.wrap = false      -- Disable line wrapping

-- File Management
opt.undofile = true  -- Save undo history to file
opt.updatetime = 250 -- Faster update time for plugins and events

-- System Integration
opt.mouse = 'a'      -- Enable mouse in all modes
opt.timeoutlen = 300 -- Timeout for mapped sequences
opt.ttimeoutlen = 30 -- Timeout for key codes

-- Visual Helpers
opt.list = true   -- Show hidden characters
opt.listchars = { -- Define how hidden characters are displayed
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    extends = '›',
    precedes = '‹',
}

-- Enable folding
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Start with all folds open
opt.foldlevel = 99

-- Only fold more than 2 lines
opt.foldminlines = 2

-- Prevent folded lines from having their background overwritten
opt.highlight:append {
    Folded = { bg = 'NONE' },
}

-- Filetype Associations
vim.filetype.add {
    extension = {
        tf = 'terraform',
        tfvars = 'terraform',
        tfstate = 'json',
        hcl = 'hcl',
        cypher = 'cypher',
        yaml = 'yaml',
        yml = 'yaml',
        conf = 'dosini',
    },
    filename = {
        ['terraform.tfstate'] = 'json',
        ['.terraform.lock.hcl'] = 'hcl',
    },
    pattern = {
        ['*.ya?ml'] = 'yaml',
    },
}

-- Autocommands
-- Highlight text on yank
local yankHighlight = vim.api.nvim_create_augroup('highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yankHighlight,
    desc = 'Highlight when yanking text',
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = "*",
})

-- Clean up white space
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    command = [[%s/\s\+$//e]],
})
