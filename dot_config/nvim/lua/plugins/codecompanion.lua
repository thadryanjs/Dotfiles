return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For completions
    "nvim-telescope/telescope.nvim", -- Optional: For symbol search
    { "stevearc/aerial.nvim", opts = {} }, -- Optional: For symbol support
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "DARTMOUTH_CHAT_API_KEY",
            },
            url = "https://chat.dartmouth.edu/api",
          }),
        },
        inline = {
          adapter = require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "DARTMOUTH_CHAT_API_KEY",
            },
            url = "https://chat.dartmouth.edu/api",
          }),
        },
      },
      -- Add more configuration here as needed
    })

    -- Keymaps for "Eyes on Code" workflow
    vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "AI Inline" })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
    vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to AI Chat" })
  end,
}
