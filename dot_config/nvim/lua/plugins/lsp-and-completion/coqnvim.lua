return {
    "ms-jpq/coq_nvim",
    enabled = true,
    lazy = false,
    -- I can't figure out how to do this to get the error to go away,
    -- https://github.com/ms-jpq/coq_nvim/issues/411, so I just use the work around for now
    config = function()
        require("coq")
        pcall(vim.cmd, "COQnow --shut-up")
        -- remap accept to ctrl-k
        -- includes the files in the gitignore by default
        -- Map Tab to accept the current autocomplete suggestion
    end
}


