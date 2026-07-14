return {
    'mbbill/undotree',
    config = function()
        vim.api.nvim_set_keymap('n', '<Leader>ut', ':UndotreeToggle<CR>', { noremap = true, silent = true })
    end

}


