return {
    "debugloop/telescope-undo.nvim",
    config = function()
        require("telescope").load_extension("undo")
        vim.keymap.set("n", "<leader>us", require("telescope").extensions.undo.undo)
    end
}
