return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    priority = 1000,
    config = function()
      vim.filetype.add({ extension = { qmd = "quarto" } })
      vim.treesitter.language.register("markdown", { "quarto", "rmd" })
    end,
  },
}
