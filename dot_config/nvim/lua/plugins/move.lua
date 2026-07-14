    return {
    "fedepujol/move.nvim",
    keys = {
      -- Normal Mode
      { "<C-j>", ":MoveLine(1)<CR>", desc = "Move Line Down" },
      { "<C-k>", ":MoveLine(-1)<CR>", desc = "Move Line Up" },
      { "<C-h>", ":MoveHChar(-1)<CR>", desc = "Move Character Left" },
      { "<C-l>", ":MoveHChar(1)<CR>", desc = "Move Character Right" },
      { "<leader>wf", ":MoveWord(-1)<CR>", mode = { "n" }, desc = "Move Word Left" },
      { "<leader>wb", ":MoveWord(1)<CR>", mode = { "n" }, desc = "Move Word Right" },
      -- Visual Mode
      { "<C-j>", ":MoveBlock(1)<CR>", mode = { "v" }, desc = "Move Block Down" },
      { "<C-k>", ":MoveBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Up" },
      { "<C-h>", ":MoveHBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Left" },
      { "<C-l>", ":MoveHBlock(1)<CR>", mode = { "v" }, desc = "Move Block Right" },
    },
    opts = {}
}
