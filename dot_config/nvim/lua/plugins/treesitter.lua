return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    priority = 1000,
    config = function()
      vim.filetype.add({ extension = { qmd = "quarto" } })
      vim.treesitter.language.register("markdown", { "quarto", "rmd" })

      local configs = pcall(require, "nvim-treesitter.configs") and require("nvim-treesitter.configs") or require("nvim-treesitter")
      
      configs.setup({
        ensure_installed = { "fsharp", "lua", "vim", "vimdoc" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      -- Force start for fsharp if automatic attach fails
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fsharp",
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
