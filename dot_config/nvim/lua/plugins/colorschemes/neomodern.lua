return {
    "casedami/neomodern.nvim",
    config = function()
        require("neomodern").setup({
          -- 'default' default background
          -- 'alt' darker background
          -- 'transparent' background is not set
          bg = "transparent",

          theme = "moon", -- 'moon' | 'iceclimber' | 'gyokuro' | 'hojicha' | 'roseprime'

          gutter = {
            cursorline = false, -- highlight the cursorline in the gutter
            dark = false, -- highlight gutter darker than the Normal bg
          },

          diagnostics = {
            darker = true, -- use darker colors for diagnostics
            undercurl = true, -- use undercurl for diagnostics
            background = true, -- use a background color for diagnostics
          },

          -- override colors, see #Customization below
          overrides = {
            default = {},
            hlgroups = {}
          }
        })

        require("neomodern").load()
    end
}
