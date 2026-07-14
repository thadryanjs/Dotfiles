-- this only works when I load another background first, and also the options passed to use() don't seem to work
-- the docs say "use" not "setup" so I'm not sure what's going on
return {
    "rockerBOO/boo-colorscheme-nvim",
    config = function()
        require("boo-colorscheme").use({
            italic = false, -- toggle italics
            theme = "boo"
        })
        vim.g.boo_colorscheme_italic = false

    end

}
