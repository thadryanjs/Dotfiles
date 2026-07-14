return {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        files = {
          find_opts = table.concat({}),
          -- rg_opts = "-g '!.pixi/*'",
          fd_opts = table.concat({ "--hidden", "--exclude", ".git" }),
        },

        -- live_grep = {
        --     -- The `--glob '!{…}'` syntax tells ripgrep to *exclude* the listed
        --     -- directories **anywhere** in the tree.
        --     rg_opts = "--ignore-case "                -- optional, makes search case‑insensitive
        --         .. "--hidden "                -- search hidden files (you can drop this)
        --         .. "--glob '!{.git,node_modules,dist,.cache,.venv}'",
        -- },
    },
    config = function()
        require("fzf-lua").setup({})

        vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', {})
        -- vim.keymap.set('n', '<leader>fg', ':FzfLua grep<CR>', {})
        vim.keymap.set('n', '<leader>fg', ':FzfLua live_grep<CR>', {})
        vim.keymap.set('n', '<leader>fr', ':FzfLua oldfiles<CR>', {})
        -- searches the content of a buffer
        vim.keymap.set('n', '<leader>sb', ':FzfLua blines<CR>', {})
    end,
}
-- https://github.com/BurntSushi/ripgrep/discussions/3176
-- https://github.com/ibhagwan/fzf-lua/discussions/1289
