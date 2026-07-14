--- [ Global Vim Settings ]

-- set dev path for lazy

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- some basic things and options from (https://github.com/jmbuhr/quarto-nvim-kickstarter)
-- use spaces as tabs
local tabsize = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize
vim.opt.autochdir = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.nvim-undo")
vim.opt.undolevels = 500
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.numberwidth = 1
-- Automatically reload files changed externally
vim.opt.autoread = true
-- Increase check interval (in milliseconds)
vim.opt.updatetime = 500
-- enable mouse
vim.opt.mouse = 'a'
vim.opt.mousefocus = true
-- use system clipboard
vim.opt.clipboard:append 'unnamedplus'
--- don't hide characters (had this as autocommand too leaving for reference)
vim.opt.conceallevel = 0
-- also no signcolumn
-- vim.opt.signcolumn = 'no'
-- vim.opt.statuscolumn = 'no'
-- vim.opt.signcolumn = 'number'
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 5
vim.opt.spell = false
vim.opt.spelllang = 'en_us'
vim.opt.spellsuggest = {'fast', 20}  -- Don't show too many suggestions for spell check
vim.opt.spellfile = vim.fn.expand("~/Vaults/Projects/Dotfiles/.config/nvim/spell/en.utf-8.add")
vim.o.timeoutlen = 30000  -- Increase timeout length to 30 seconds
-- vim.opt.signcolumn = "yes"im.o.scl = "no"
-- translating "set formatoptions-=r"
-- doesn't work: https://www.reddit.com/r/neovim/comments/11ij7t4/how_to_set_formatoptionso_in_lua/
--vim.opt.formatoptions:remove({ 'o' })
-- vim.cmd(":set formatoptions-=r")

-- [ Folds ]j
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.custom_fold_expr(v:lnum)' -- Custom fold expression function
vim.opt.foldlevelstart=20

function _G.custom_fold_expr(lnum)
  local line = vim.fn.getline(lnum)
  if line:match('^# %%') then
    return '>1' -- Start a new fold level
  elseif line:match('^$') then
    return '=' -- Keep previous fold level for empty lines
  end
  return '1' -- Default fold level
end
-- vim.opt.foldmethod = "manual"

-- vim.opt.foldmethod = "indent"

-- this gives me an error saying this can't be a number but the docs say it has to be
-- a number https://neovim.io/doc/user/fold.html#_foldcolumn
-- it works when I set it manually in the while running
-- works with quotes but works with ints in live nvim lol
vim.opt.foldcolumn = "auto"


-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true


-- [ LSP/Diagnostic settings ]
vim.o.updatetime = 500

-- how lsp diagnostics are displayed
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = false,
}

-- code folding is evil
-- vim.opt.foldenable = false

-- filetype
vim.cmd [[ filetype plugin on ]]


-- show hover instead of inline lsp diagnostics (absuredly based)
-- https://stackoverflow.com/questions/69290794/nvim-lsp-change-lspconfig-diagnostic-message-location
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- python provider
vim.g.python3_host_prog = '/usr/bin/python3'


-- This is a hack because neotree messes with :bd
function CloseCurrentBufferAndSwitchOrQuit()
  local curr_buf = vim.api.nvim_get_current_buf()
  local listed_buffers = {}

  -- Collect listed buffers
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(bufnr) == 1 and vim.api.nvim_buf_is_loaded(bufnr) then
      table.insert(listed_buffers, bufnr)
    end
  end

  if #listed_buffers <= 1 then
    -- Last buffer, so quit Neovim
    vim.cmd('quit')
    return
  end

  -- Try to switch to alternate buffer
  local alt_buf = vim.fn.bufnr('#')
  if alt_buf == -1 or alt_buf == curr_buf or not vim.api.nvim_buf_is_loaded(alt_buf) then
    -- Fallback: pick any listed buffer except current
    for _, bufnr in ipairs(listed_buffers) do
      if bufnr ~= curr_buf then
        alt_buf = bufnr
        break
      end
    end
  end

  -- Switch to alt_buf
  if vim.api.nvim_buf_is_valid(alt_buf) then
    vim.api.nvim_set_current_buf(alt_buf)
  else
    -- No valid buffer to switch to, just open a new one
    vim.cmd('enew')
  end

  -- Delete current buffer
  if vim.api.nvim_buf_is_valid(curr_buf) then
    vim.api.nvim_buf_delete(curr_buf, { force = false })
  end
end

vim.api.nvim_set_keymap('n', '<leader>bd', ':lua CloseCurrentBufferAndSwitchOrQuit()<CR>', { noremap = true, silent = true })

local home = vim.loop.os_homedir()  -- get expanded home directory

function DailyNote()
  local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
  local filename = timestamp .. ".md"
  local filepath = vim.fn.expand("~/Vaults/Home/Projects/DailyNotes/") .. filename

  -- Open the file
  vim.cmd("edit " .. filepath)

  -- Add date header
  local date_header = "# " .. os.date("%A, %B %d, %Y")
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { date_header, "" })
end

-- Optional: Add a keybinding
vim.keymap.set("n", "<leader>jn", DailyNote, { noremap = true, silent = true })

-- italics do not belong in code
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = function()
    vim.fn.foreach(vim.api.nvim_get_hl(0, {}), function(hlname, def)
      local is_italic = def.italic or def.cterm and def.cterm.italic
      if not is_italic then
        return
      end

      local disabled_def = vim.tbl_deep_extend('force', def, { italic = false, cterm = { italic = false } })
      vim.api.nvim_set_hl(0, hlname, disabled_def)
    end)
  end,
})
