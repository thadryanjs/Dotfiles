---- [ Convenience Function ]

-- functions to save some typing/ease readability
-- ( https://vi.stackexchange.com/questions/37187/how-can-i-port-nmap-map-and-imap-commands-to-lua-configuration
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end


-- PLEASE
imap("jj", "<Esc>")

-- save with ctrl+s
imap("<C-s>", "<cmd>:w!<cr><esc>")
nmap("<C-s>", "<cmd>:w!<cr><esc>")

nmap("j",  "gj")
nmap("k", "gk")
nmap("<Up>", "gk")
nmap("<Down>", "gj")
nmap("<C-c>", '"+y')
nmap("<C-v>", '"+p')


-- autocomplete
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.pumvisible() ? "<C-Y>" : "<CR>"', { expr = true, noremap = true })

-- home and queue m

-- preview buffer (https://stackoverflow.com/questions/28808922/quickly-switch-to-the-last-edited-buffer)
nmap("<leader>pp", "<C-^>")

-- [ Buffer padding ]
nmap("<leader>lz", ":vs buffer | :vertical resize -120<cr>")

-- [ Jupyter Notebook script hotkeys]
-- insert and normal mode version
imap("<C-o>", "# %% [code]")
-- looks weird, but it makes sure the markdown cell is automatically closed,
-- first line is commented out, and is placed back automatically
imap("<A-m>", "# %% [markdown]<CR><Esc>O\n\n# %% [code]<Esc>2ki# ")
nmap("<leader>jc", "i# %% [code]")
nmap("<leader>jm", "O# %% [markdown]<CR><Esc>O\n\n# %% [code]<Esc>2ki# ")

-- toggle code blocks
nmap("<leader>jt", ":ToggleCell<CR>")
--nmap("<leader>jp", ":ToggleCell<CR>")

-- find code tags
nmap("<leader>jf", "/# %% \\[code\\]<CR>")
-- remove all code tags

imap("<A-e>", ":%s/# %% \\[code\\]<CR>")
-- toggle code tags for Jupyter/IDE cells
vim.api.nvim_create_user_command("ToggleCell", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local modified = false

    for i, line in ipairs(lines) do
        -- Check for a standard cell marker
        if line:find("^# %%%% ") then
            -- Replace with the inactive delimiter
            lines[i] = "# [inactive delimiter] [code]"
            modified = true
        -- Check for the inactive delimiter
        elseif line:find("^# %[inactive delimiter%] ") then
            -- Replace with the standard cell marker
            lines[i] = "# %% [code]"
            modified = true
        end
    end

    if modified then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end
end, {})


-- close all buffers except current
-- :w | %bd | e# | bd
nmap("<leader>ca", ":w | %bd | e# | bd#<CR>")

-- open quickfix
nmap("<leader>qo", ":copen <CR>")
nmap("<leader>qc", ":cclose <CR>")
-- remove current quickfix entry under cursor (apparently impossible lol)

-- set no conceal
nmap("<leader>nc", ":setlocal conceallevel=0<CR>")

-- insert date
nmap("<leader>dd", ":put=strftime('%Y-%m-%d')<CR>A ")
-- nmap("<leader>dd", ":put=system('date +\\%Y-\\%m-\\%d')<CR>A ")

-- [ Quarto hotkeys ]
-- imap("<A-r>", "```{r}\n\n```")
-- imap("<A-y>", "```{python}\n\n```<esc>")
-- imap("<A-l>", "```{julia}\n\n```<esc>")

-- remove highlighting
nmap("<leader>hr", ":nohl<CR>")

-- cd to current file directory
nmap("<leader>cd", ":cd %:p:h<CR>")

-- telescope buffers
-- nmap("<leader>fb", "<cmd>Telescope buffers<CR>")
nmap("<leader>bp", "<cmd>bprevious<CR>")
nmap("<leader>bn", "<cmd>bnext<CR>")
nmap("<leader>bc", "<cmd>bnext<CR>")

-- telescope: show keymaps
nmap("<leader>tk", "<cmd>Telescope keymaps<CR>")

-- pipe operator
imap("kk", "%>%")

-- vault picker (fzf-lua)
vim.keymap.set('n', '<leader>ws', function()
    local vaults = {
        { name = "Knowledge", path = "~/Vaults/Knowledge", file = "Knowledge.org" },
        { name = "Home", path = "~/Vaults/Home", file = "HomeVault.org" },
        { name = "Projects", path = "~/Vaults/Projects", file = "Projects.org" },
        { name = "Master", path = "~/Vaults", file = "index.md" },
    }

    local choices = {}
    for i, v in ipairs(vaults) do
        table.insert(choices, string.format("%d. %s", i, v.name))
    end

    local choice = vim.fn.inputlist(choices)
    if choice > 0 and choice <= #vaults then
        local vault = vaults[choice]
        vim.cmd(string.format("cd %s | edit %s", vim.fn.expand(vault.path), vault.file))
    end
end, { desc = "Switch vault" })

-- Quick org TODO capture (pure Lua, dynamic date)
vim.keymap.set('n', '<leader>td', function()
    local date = os.date('<%Y-%m-%d %a>')
    local line = '** TODO [#B] '
    local scheduled = '    SCHEDULED:  ' .. date

    -- Insert the TODO line below current cursor
    vim.api.nvim_put({line, scheduled}, 'l', true, true)

    -- nvim_put leaves cursor on last inserted line, move up one and to end of first line
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local line_len = #line
    vim.api.nvim_win_set_cursor(0, {cursor_line, line_len})

    -- Enter insert mode
    vim.api.nvim_feedkeys('i', 'n', false)
end, { desc = "Org TODO with date" })

-- WorkVault shortcuts
nmap("<leader>ww", ":edit ~/Vaults/Knowledge/Knowledge.org<CR>")
nmap("<leader>wm", ":split ~/Vaults/Knowledge/Knowledge.org<CR>")

-- when I ask to open a file, make it if it doesn't exist
nmap('gf', ':e <cfile><cr>')

-- wait what is this?
-- local keyset = vim.keymap.set
-- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
-- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

-- Jump to next diagnostic (any type: error, warn, info, hint, spell)
nmap('<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

--- Navbuddy
-- I can't get the config to work in the file for some reason so I have to make this untidy :/
nmap("<leader>nb", "<cmd>Navbuddy<CR>")
-- t is search

-- minal diagnostics
vim.api.nvim_create_user_command("DiagnosticsLight", function()
    vim.diagnostic.config {
        virtual_text = false,
        signs = false,
        underline = true,
    }
end, {})

-- normal diagnostics
vim.api.nvim_create_user_command("DiagnosticsMedium", function()
    vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = false,
    }
end, {})

-- heavy duty, once-in-a-while diagnostics
vim.api.nvim_create_user_command("DiagnosticsHeavy", function()
    vim.diagnostic.config {
        virtual_text = true,
        signs = true,
        underline = true,
    }
end, {})


-- Remove ANSI escape codes from the current buffer
vim.api.nvim_create_user_command("RemoveAnsi", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)  -- Get all lines in the current buffer
    for i, line in ipairs(lines) do
        -- Remove ANSI escape codes using Lua pattern matching
        lines[i] = line:gsub("\x1B%[[0-9;]*m", "")
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)  -- Set modified lines back to the buffer
end, {})


vim.api.nvim_create_user_command("ToggleSpellcheck", function ()
      -- Check if spellcheck is currently on
      if vim.opt.spell:get() then
        -- Turn it off and disable the highlight
        vim.opt.spell = false
        vim.cmd("highlight Underlined gui=underline")
        print("Spellcheck and underline are now OFF")
      else
        -- Turn it on and enable the highlight
        vim.opt.spell = true
        vim.cmd("highlight Underlined gui=none")
        print("Spellcheck and underline are now ON")
      end
end, {})

vim.api.nvim_create_user_command("SetPixiPythonEnv", function()
    local python_path = vim.fn.trim(vim.fn.system("pixi run which python"))
    vim.g.python3_host_prog = python_path
    print("Pixi Python environment set to: " .. python_path)
end, {})


local function move_hash_up()
  local buf = vim.api.nvim_get_current_buf()
  local r   = vim.api.nvim_win_get_cursor(0)[1] - 1   -- 0‑based line index
  local line = vim.api.nvim_buf_get_lines(buf, r, r+1, false)[1]

  -- split at the first '#'
  local col = line:find('#')
  local code    = line:sub(1, col-1)          -- part before '#'
  local comment = line:sub(col)              -- '# …'

  -- keep original indentation
  local indent = code:match('^%s*') or ''

  -- build the two new lines
  local new_comment = indent .. comment:gsub('^%s*#%s*', '# ')  -- tidy up spacing
  local new_code    = code:gsub('%s+$', '')                    -- drop trailing ws

  -- replace current line with the code‑only line
  vim.api.nvim_buf_set_lines(buf, r, r+1, false, { new_code })
  -- insert the comment line *above*
  vim.api.nvim_buf_set_lines(buf, r, r, false, { new_comment })

  -- optional: put cursor on the comment line
  vim.api.nvim_win_set_cursor(0, { r, #new_comment })
end

vim.keymap.set('n', '<leader>cm', move_hash_up, { desc = 'Move # comment up' })
