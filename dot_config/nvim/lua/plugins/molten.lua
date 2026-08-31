return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', { desc = "Molten Init" })
    end,
  },
  {
    "3rd/image.nvim",
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
