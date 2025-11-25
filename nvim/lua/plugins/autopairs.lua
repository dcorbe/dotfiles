return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        -- Don't add pairs if the next char is alphanumeric
        ignored_next_char = "[%w%.]",
        -- Use tree-sitter to check for pairs
        check_ts = true,
        ts_config = {
            -- Don't add pairs inside these tree-sitter node types
            lua = { "string", "comment" },
            javascript = { "string", "template_string", "comment" },
            typescript = { "string", "template_string", "comment" },
            rust = { "string_literal", "char_literal", "line_comment", "block_comment" },
            python = { "string", "comment" },
            -- Add more languages as needed
        },
        -- Disable in certain filetypes
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
    },
}

