-- This has stopped working even though I didn't update.
-- Copy/pasting the commands from the readme doesn't work either.
return {
    "ThePrimeagen/harpoon",
    -- specify the brach to use
    branch = "harpoon2",
    enabled = false,
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        }
    },
    config = function()

        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED
        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end)
        vim.keymap.set("n", "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>hj", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader>hk", function() harpoon:list():next() end)

        --[[
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

        vim.api.nvim_set_keymap("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>",
        { noremap = true, silent = true })

        vim.api.nvim_set_keymap("n", "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<CR>",
        { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>h5", ":lua require('harpoon.ui').nav_file(5)<CR>",
        { noremap = true, silent = true })

        ]]--
    end
}
