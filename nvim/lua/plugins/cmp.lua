return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- LSP source
        "hrsh7th/cmp-nvim-lsp-signature-help",  -- LSP signature help
        "hrsh7th/cmp-buffer",        -- Buffer source
        "hrsh7th/cmp-path",          -- Path source
        "L3MON4D3/LuaSnip",          -- Snippet engine
        "saadparwaiz1/cmp_luasnip",  -- Snippet source
        "zbirenbaum/copilot-cmp",    -- Copilot source
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Setup copilot-cmp
        require("copilot_cmp").setup()

        -- Track if completions are enabled (default: true)
        local cmp_enabled = true

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                autocomplete = {
                    cmp.TriggerEvent.TextChanged,
                },
            },
            enabled = function()
                return cmp_enabled
            end,
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping(function()
                    cmp_enabled = not cmp_enabled
                    if cmp_enabled then
                        cmp.complete()
                    else
                        cmp.abort()
                    end
                end),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = "nvim_lsp", group_index = 2 },
                { name = "nvim_lsp_signature_help", group_index = 2 },
                { name = "luasnip", group_index = 2 },
                { name = "path", group_index = 2 },
            }, {
                { name = "buffer", group_index = 3 },
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- Add spacing by setting a max width for abbr
                    local content = vim_item.abbr
                    if #content > 40 then
                        vim_item.abbr = vim.fn.strcharpart(content, 0, 40) .. "…"
                    else
                        vim_item.abbr = content .. string.rep(" ", 40 - #content)
                    end

                    -- Source names
                    vim_item.menu = ({
                        copilot = "[Copilot]",
                        nvim_lsp = "[LSP]",
                        nvim_lsp_signature_help = "[Sig]",
                        luasnip = "[Snip]",
                        buffer = "[Buf]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
        })
    end,
}
