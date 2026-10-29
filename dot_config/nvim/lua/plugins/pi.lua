return {
  "carderne/pi-nvim",
  config = function()
    local pi = require("pi-nvim")
    pi.setup()

    -- The plugin typically provides functions to send messages to the pi socket.
    -- We'll define keybindings to make these actions frictionless.

    local function send_to_pi(type, content)
      -- pi-nvim usually exposes a 'send' or similar function
      -- We wrap it in a pcall to avoid crashing if pi isn't running
      local ok, pi = pcall(require, "pi-nvim")
      if not ok then
        vim.notify("Pi plugin not loaded", vim.log.levels.ERROR)
        return
      end

      -- Send based on the interaction type
      if type == "selection" then
        pi.send_selection()
      elseif type == "file" then
        pi.send_file()
      elseif type == "prompt" then
        pi.prompt()
      end
    end

    -- Keymaps to bridge Nvim -> Pi
    vim.keymap.set({ "n", "v" }, "<leader>pp", function() send_to_pi("prompt") end, { desc = "Pi: Send Prompt" })
    vim.keymap.set({ "n", "v" }, "<leader>px", function() send_to_pi("selection") end, { desc = "Pi: Send Selection" })
    vim.keymap.set("n", "<leader>pf", function() send_to_pi("file") end, { desc = "Pi: Send Current File" })
    vim.keymap.set("n", "<leader>ps", function() require("pi-nvim").list_sessions() end, { desc = "Pi: Switch Session" })
  end,
}
