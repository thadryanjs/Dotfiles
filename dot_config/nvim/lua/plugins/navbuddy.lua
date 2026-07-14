return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } },
            -- config = function()
            --     require("nvim-navbuddy").setup({
            --     -- map key
            --     vim.keymap.set("n", "<leader>nb", ":Navbuddy<cr>", { noremap = true, silent = true })
            --     })
            -- end
        }
    },
    -- your lsp config or other stuff
}
