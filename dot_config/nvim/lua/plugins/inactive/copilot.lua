return {
    "github/copilot.vim",
    enabled = false,
    config = function()
        vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("")', {expr=true, noremap=true, script=true})
    end
}
