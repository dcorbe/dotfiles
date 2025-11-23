return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    event = "BufRead",
    config = function()
        -- Set up fold-related options
        vim.o.foldcolumn = '1' -- Show fold column (0-9, 0 to disable)
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open folds except kinds' })
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds with' })

        -- Peek into fold without opening it
        vim.keymap.set('n', 'K', function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                -- Use LSP hover if no fold found
                vim.lsp.buf.hover()
            end
        end, { desc = 'Peek fold or hover' })

        require('ufo').setup({
            -- Use treesitter as main provider, fallback to LSP, then indent
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end,
            -- Customize fold text to show first line and line count
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d lines'):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end

                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end,
        })
    end,
}
