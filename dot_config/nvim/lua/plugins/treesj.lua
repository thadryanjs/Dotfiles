return {
    'Wansmer/treesj',
    -- keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
        require('treesj').setup({
            --[[ your config ]]
            --vim.api.nvim_set_keymap('n', '<leader>tt', 'TSJToggle', {})
        })
    end,
}
