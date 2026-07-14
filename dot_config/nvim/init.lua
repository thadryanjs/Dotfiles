require "config.global"
require "config.keymaps"
require "config.lazy"
require "config.autocmds"

-- tried and true
-- vim.cmd("colorscheme kanagawa-dragon")
-- vim.cmd("colorscheme koda")
-- -- -- -- vim.cmd("colorscheme yugen")
vim.cmd("colorscheme moon")

-- maybe
-- vim.cmd("colorscheme darkmatter")


-- 'completion request failed: {"code":"unknown","message":"canceled: request 156 is stale"}'
-- need to figure out why this is happening
-- claude says ltek is not honoring filetypes
-- this is a hack that works for now
-- local original_notify = vim.notify
-- vim.notify = function(msg, ...)
--     if type(msg) == "string" and msg:match("request.*is stale") then
--         return
--     end
--     original_notify(msg, ...)
-- end
