return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
        -- 'default' for mappings similar to built-in vim completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        keymap = { preset = "super-tab" },

        appearance = {
            use_nvim_cmp_as_default = true,
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'normal'
            -- nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        -- completion = { documentation = { auto_show = false } },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    },
    config = function(_, opts)
        local ok, blink = pcall(require, 'blink.cmp')
        if not ok then
            vim.notify('Failed to load blink.cmp', vim.log.levels.ERROR)
            return
        end
        blink.setup(opts)
    end,
}
