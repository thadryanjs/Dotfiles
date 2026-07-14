return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {

    },
    config = function()
        -- this sets the working dir - could be useful so I'm leaving it but not using it for now
        --            nmap('<c-b>', ':Neotree toggle dir=%:p:h<CR>')
        nmap('<C-n>', ':Neotree toggle<CR>')
        -- start open
        require("neo-tree").setup({
            window = {
                width = 27
            },
            filesystem = {
                filtered_items = {
                    hide_gitignored = false,
                }
            }
        })

    end
}
