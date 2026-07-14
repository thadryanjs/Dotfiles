return {
    "Cannon07/code-preview.nvim",
    config = function()
        require("code-preview").setup({
          diff = {
            layout   = "tab",    -- "tab" (new tab) | "vsplit" (current tab) | "inline" (GitHub-style)
            labels   = { current = "CURRENT", proposed = "PROPOSED" },
            auto_close = true,   -- close diff after accept
            equalize   = true,   -- 50/50 split widths (tab/vsplit only)
            full_file  = true,   -- show full file, not just diff hunks (tab/vsplit only)
          },
          highlights = {
            current = {          -- CURRENT (original) side — tab/vsplit layouts
              DiffAdd    = { bg = "#4c2e2e" },
              DiffDelete = { bg = "#4c2e2e" },
              DiffChange = { bg = "#4c3a2e" },
              DiffText   = { bg = "#5c3030" },
            },
            proposed = {         -- PROPOSED side — tab/vsplit layouts
              DiffAdd    = { bg = "#2e4c2e" },
              DiffDelete = { bg = "#4c2e2e" },
              DiffChange = { bg = "#2e3c4c" },
              DiffText   = { bg = "#3e5c3e" },
            },
            inline = {           -- inline layout
              added        = { bg = "#2e4c2e" },          -- added line background
              removed      = { bg = "#4c2e2e" },          -- removed line background
              added_text   = { bg = "#3a6e3a" },          -- changed characters (added)
              removed_text = { bg = "#6e3a3a" },          -- changed characters (removed)
            },
          },
          neo_tree = {
            enabled = true,             -- set false to disable neo-tree integration
            position = "left",         -- neo-tree window position: "left", "right", "float"
            symbols = {
              modified = "󰏫",
              created  = "󰎔",
              deleted  = "󰆴",
            },
            highlights = {
              modified = { fg = "#e8a838", bold = true },
              created  = { fg = "#56c8d8", bold = true },
              deleted  = { fg = "#e06c75", bold = true, strikethrough = true },
            },
          }

        })
    end
}
