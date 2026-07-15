-- coq_nvim is your ONE completion engine.
-- It owns the popup (as-you-type) and provides the filesystem path source
-- that completes  read.csv("./data<Tab>  etc.
return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  enabled = true,
  lazy = false,
  -- Optional but recommended: snippets + extra sources (paths, buffers, etc.)
  -- Comment these out if you want the leanest possible setup.
  dependencies = {
    "ms-jpq/coq.artifacts",   -- snippet definitions
    "ms-jpq/coq.thirdparty",  -- extra sources
  },
  -- init runs BEFORE the plugin loads. coq requires its settings to be set
  -- here, not in config(). This also resolves the issue #411 nag the old
  -- comment was fighting -- "shut-up" starts coq silently, no COQnow needed.
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",           -- start coq, suppress the startup message
      keymap = {
        recommended = true,             -- coq owns <CR>/<Tab>/<S-Tab> in insert mode
        -- If you'd rather bind these yourself, set recommended = false
        -- and define jump_to_mark / manual_complete below.
      },
      -- Completion display tuning (all optional):
      display = {
        pum = {
          fast_close = false,
        },
      },
    }
  end,

  config = function()
    require("coq")
  end,
}

