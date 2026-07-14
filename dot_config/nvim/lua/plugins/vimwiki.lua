return {
    "vimwiki/vimwiki",
    enabled = false,
    init = function()
        vim.g.vimwiki_list = {
            {
                path = '~/Vaults/Knowledge/',
                syntax = 'markdown',
                ext = '.md',
            },
            {
                path = '~/Vaults/Home/',
                syntax = 'markdown',
                ext = '.md',
            },
                path = '~/Vaults/Projects/',
                syntax = 'markdown',
                ext = '.md',

            }
        end,
        config = function()
            vim.keymap.set('n', '<leader>lc', ": VimwikiToggleListItem<CR>", {})
            vim.keymap.set('n', '<leader>la', 'i- [ ] ', {})
            vim.keymap.set('n', '<leader>lf', function()
                require('fzf-lua').live_grep {
                    search = "- [ ]",
                    prompt = "> TODOS (- [ ])> ",
                }
            end, { silent = true })
        end

}

