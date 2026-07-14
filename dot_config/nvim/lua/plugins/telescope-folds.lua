return {
    'roosta/telescope-folds.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    config = function()
        require('telescope').load_extension('folds')
    end
}
