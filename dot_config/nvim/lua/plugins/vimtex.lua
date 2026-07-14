return {
    "lervag/vimtex",
    lazy = false, -- load early for full functionality
    config = function()
        -- vim.g.vimtex_view_method = "general" -- use system default pdf viewer
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 2 -- show quickfix on errors/warnings
        vim.g.vimtex_indent_enabled = 1
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_fold_enabled = 1

        -- Keymaps
        vim.api.nvim_set_keymap("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true, desc = "Compile LaTeX" })
        vim.api.nvim_set_keymap("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true, desc = "View PDF" })
        vim.api.nvim_set_keymap("n", "<leader>lc", ":VimtexClean<CR>", { noremap = true, silent = true, desc = "Clean LaTeX" })
        vim.api.nvim_set_keymap("n", "<leader>li", ":VimtexInfo<CR>", { noremap = true, silent = true, desc = "Vimtex Info" })
    end,
    ft = { "tex", "bib" },
}
