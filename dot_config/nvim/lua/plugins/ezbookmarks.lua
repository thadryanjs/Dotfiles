-- this doesn't replace harpoon but it works for quick captures
return{
    "lifer0se/ezbookmarks.nvim",
    lazy = false,
    enabled = true,
    config = function()

        require('ezbookmarks').setup{
            -- change directory when opening a bookmark
            cwd_on_open = 0,
            -- if a bookmark is part of a bookmarked directory, cd to that direcrtory (works independently of cwd_on_open)
            use_bookmark_dir = 0
        }

        vim.api.nvim_set_keymap("n", "<leader>ka", ":lua require('ezbookmarks').AddBookmark()<CR>",
        { noremap = true, silent = true })

        vim.api.nvim_set_keymap("n", "<leader>kr", ":lua require('ezbookmarks').RemoveBookmark()<CR>",
        { noremap = true, silent = true })

        vim.api.nvim_set_keymap("n", "<leader>kf", ":lua require('ezbookmarks').OpenBookmark()<CR>",
        { noremap = true, silent = true })

    end
}

