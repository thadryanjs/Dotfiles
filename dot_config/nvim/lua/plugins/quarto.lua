return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      -- .qmd -> quarto filetype, and tell treesitter that filetype uses the
      -- markdown parser (nvim-treesitter no longer registers this itself)
      vim.filetype.add({ extension = { qmd = "quarto" } })
      vim.treesitter.language.register("markdown", { "quarto", "rmd" })
    end,
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
        ft_runners = {
          r = "molten",
          python = "molten",
          julia = "molten",
        },
        never_run = { "yaml" },
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      -- Remove background noise from code cells
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "quarto", "markdown" },
        callback = function()
          local groups = {
            "@markup.raw.block",
            "@markup.raw",
            "@markup.raw.block.markdown",
            "@text.literal.block",
            "markdownCodeDelimiter",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE" })
          end
        end,
      })

      local runner = require("quarto.runner")
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end

      map("n", "<localleader>rc", runner.run_cell, "run cell")
      map("n", "<localleader>ra", runner.run_above, "run cell and above")
      map("n", "<localleader>rb", runner.run_below, "run cell and below")
      map("n", "<localleader>rA", runner.run_all, "run all cells")
      map("n", "<localleader>rl", runner.run_line, "run line")
      map("v", "<localleader>r", runner.run_range, "run visual range")
      map("n", "<localleader>RA", function()
        runner.run_all(true)
      end, "run all cells, all languages")
      map("n", "<localleader>qp", require("quarto").quartoPreview, "quarto preview")
      map("n", "<leader>qs", ":QuartoSend<CR>", "quarto send")
      map("n", "<leader>qa", ":QuartoSendAbove<CR>", "quarto send above")
      map("n", "<leader>qb", ":QuartoSendBelow<CR>", "quarto send below")
      map("n", "<leader>qf", ":QuartoSendAll<CR>", "quarto send all")
      map("n", "<leader>qo", ":QuartoActivate<CR>", "quarto activate")
    end,
  },
}
