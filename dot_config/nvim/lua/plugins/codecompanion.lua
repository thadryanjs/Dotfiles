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
      opts = { log_level = "DEBUG" },
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.3,
          },
        },
      },
      adapters = {
        http = {
          dartmouth = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "dartmouth",
              formatted_name = "Dartmouth Chat",
              env = {
                url = "https://chat.dartmouth.edu/api",
                api_key = "DARTMOUTH_CHAT_API_KEY",
                chat_url = "/chat/completions",
                models_endpoint = "/models",
              },
              schema = {
                model = {
                  default = "google.gemma-4-31B-it",
                  choices = { "google.gemma-4-31B-it" },
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = "dartmouth" },
        inline = { adapter = "dartmouth" },
      },
    })

    -- Keymaps for "Eyes on Code" workflow
    vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "AI Inline" })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
    vim.keymap.set("v", "<leader>cp", function()
      -- Open chat and insert the selection reference
      vim.cmd("CodeCompanionChat Toggle")
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("#{selection} ", true, false, true), "n", false)
    end, { desc = "AI: Reference Selection in Chat" })
    vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>CodeCompanionActions<cr>", { desc = "AI Action Palette" })
  end,
}
