return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', { desc = "Molten Init" })
      vim.keymap.set('n', '<leader>me', ':MoltenDelete<CR>', { desc = "Molten Erase" })
      
      -- Remove background noise from Molten output and cell highlighting
      vim.api.nvim_set_hl(0, "MoltenOutput", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "MoltenOutputError", { bg = "NONE" })

      -- Nuke all Molten backgrounds to stop "color noise"
      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInit",
        callback = function()
          for _, hl in ipairs(vim.api.nvim_get_hl()) do
            -- This is a bit hacky but finds all Molten highlight groups
            -- Note: nvim_get_hl returns keys as IDs, we need names
          end
        end,
      })
      
      -- simpler approach: target likely group names
      local molten_groups = {
        "MoltenCell",
        "MoltenActiveCell",
        "MoltenExecutedCell",
        "MoltenRunningCell",
        "MoltenErrorCell",
      }
      for _, group in ipairs(molten_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
      end
    end,
  },
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign", "" },
      tmux_show_only_in_active_window = true,
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "quarto" },
        },
        neorg = { enabled = false },
        typst = { enabled = false },
        html = { enabled = false },
        css = { enabled = false },
      },
    },
  },
}
