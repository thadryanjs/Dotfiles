return {
    "Exafunction/windsurf.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                key_bindings = {
                    accept = "<C-j>",
                    accept_word = "<C-k>",
                    accept_line = "<C-l>",
                    clear = "<C-c>",          -- Optional: Set key binding for clearing the virtual text
                    next = "<C-]>",           -- Key binding for cycling to the next completion
                    prev = "<C-[>",           -- Key binding for cycling to the previous completion
                }
            }
        })
        vim.keymap.set(
          "n",                     -- normal mode
          "<leader>tc",            -- <leader> t c
          ":Codium Toggle<CR>",    -- invoke the command
          { noremap = true, silent = true, desc = "Toggle Codeium" }
        )
    end
}
