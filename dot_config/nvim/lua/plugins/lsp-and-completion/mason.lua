return {
    "williamboman/mason.nvim",
    enabled = true,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    opts = {
        -- this is not a standard option for Mason, it's for use with a custom command (see config)
        ensure_installed = {
            -- python
            "pyright",
            "ty",
            "pyrefly",
            "r_languageserver",
            "ltex-ls",
            "lua-language-server",
            "clangd",
            "marksman"
        }
    },

    config = function(_, opts)

        require("mason").setup({
            -- custom nvchad cmd to install all mason binaries listed
            -- https://github.com/NvChad/NvChad/blob/3091ea58359bb85f087499bd73fbc0a57a935c34/lua/plugins/init.lua#L121
            -- This just install everything in the enure_installed list at once
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})

        })

    end
}

