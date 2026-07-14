return {
    "natecraddock/workspaces.nvim",
    config = function()
        require("workspaces").setup({
            path = "/home/thadryan/.workspaces.txt"
        })

        vim.api.nvim_set_keymap("n", "<leader>wf", ":Telescope workspaces<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>wv", ":e /home/thadryan/Documents/Vault/index.md<CR>",
        { noremap = true, silent = true })



        -- vim.api.nvim_set_keymap("n", "<leader>wi", ":e *.org<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>wa", ":WorkspacesAdd<CR>", { noremap = true, silent = true })

    end
}
