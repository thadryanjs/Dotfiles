return {
    "adigitoleo/overview.nvim",
    enabled = false,
    config = function()
        local overview = require("overview")
        vim.keymap.set("n", "gO", overview.toggle, { desc = "Toggle Overview sidebar for current buffer" })
        vim.keymap.set("n", "go", overview.focus, { desc = "Toggle focus between Overview sidebar and source buffer" })
    end
}
