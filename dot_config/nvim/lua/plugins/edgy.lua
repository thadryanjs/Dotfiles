return {
    "folke/edgy.nvim",
    config = function()
        require("edgy").setup({
          left = {
            {
              title = "Files",
              ft = "neo-tree",
              size = { height = 0.65 },
            },
            {
              title = "Outline",
              ft = "Outline",
              size = { height = 0.35 },
            },
          },
          options = {
            left = { size = 30 },
          },
          animate = { enabled = false },
          exit_when_last = false,
          close_when_all_hidden = true,
        })
    end
}
