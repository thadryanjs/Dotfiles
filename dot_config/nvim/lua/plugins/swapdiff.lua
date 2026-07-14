return {
  'trippwill/swapdiff.nvim',
  enabled = false,
  config = function()
    local levels = require('vim.log').levels
    require('swapdiff').setup({
      prompt_config = {
        style = 'Interactive', -- Options: 'Interactive', 'Notify', 'None'
        once = false, -- Show prompt only once per swapfile
      },
      log_level = levels.DEBUG,
      notify_level = levels.INFO,
      log_win_config = {
        relative = 'editor',
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        row = math.floor((vim.o.lines - vim.o.lines * 0.8) / 2),
        col = math.floor((vim.o.columns - vim.o.columns * 0.8) / 2),
        style = 'minimal',
        border = 'rounded',
        title = 'SwapDiff Log',
        footer = '<q> to close',
        footer_pos = 'right',
      },
    })
  end
}
