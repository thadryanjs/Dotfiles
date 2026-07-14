-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    ".git/", ".cache", "%.pdf", "%.mkv", "%.mp4", "%.zip", ".snakemake", ".ipynb_checkpoints", ".pixi",
                    "_build/*.*", "target/*.*", "libs/*.*", "html/*.*", "node_modules/*.*", "dist/*.*", "build/*.*",
                    ".obsidian/*.*"
                },
            },
            pickers = {
                marks = {
                    attach_mappings = function(prompt_bufnr, map)
                        map("i", "<C-d>", function()
                            require("telescope.actions").delete_mark(prompt_bufnr)
                        end)
                        return true -- Keep default mappings as well as the custom ones
                    end,
                },
                buffers = {
                    attach_mappings = function(prompt_bufnr, map)
                        map("i", "<C-x>", function()
                            require("telescope.actions").delete_buffer(prompt_bufnr)
                        end)
                        return true -- Keep default mappings as well as the custom ones
                    end,
                }
            },
        })
        -- these are the ones suggested in the docs
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')
        -- includes the files in the gitignore by default
        -- moving to fzf lua because it works on CIFS mount
        -- vim.keymap.set('n', '<leader>ff', ":Telescope find_files hidden=true no_ignore=true<CR>", { noremap = true, silent = true })
        -- search for version control tracked files only
        vim.keymap.set('n', '<leader>ft', builtin.find_files, {})
        -- live grep for strings in many files
        -- moving to fzf lua because it works on CIFS mount
        -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        -- search open buffers
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        -- searches the text under the cursor
        vim.keymap.set('n', '<leader>fu', builtin.grep_string, {})
        -- search help pages
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        -- searches recent files
        -- moving to fzf lua because it works on CIFS mount
        -- vim.keymap.set('n', '<leader>fr', ":Telescope oldfiles<cr>")

        -- fuzzy find dirs in project and tcd into selection
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local function find_dirs()
            pickers.new({}, {
                prompt_title = "Project Dirs",
                finder = finders.new_oneshot_job(
                    { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
                    {}
                ),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("tcd " .. selection[1])
                        print("cwd -> " .. selection[1])
                    end)
                    return true
                end,
            }):find()
        end
        vim.keymap.set('n', '<leader>fd', find_dirs, { desc = "Fuzzy find dir & tcd" })

        telescope.load_extension("workspaces")
        -- telescope.load_extension('vim_bookmarks')
        -- this doesn't work and I didn't need to do it before
        -- telescope.load_extension("harpoon")
    end
}
