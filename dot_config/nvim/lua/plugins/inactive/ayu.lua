return {
    "Shatur/neovim-ayu",
    enabled = false,
    config = function()
        require('ayu').setup({
            overrides = {
                Normal = {bg = "None"}
            }
        })
    end,
}
