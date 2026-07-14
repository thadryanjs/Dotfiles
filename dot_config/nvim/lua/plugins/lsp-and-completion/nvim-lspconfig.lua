return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.log.set_level("WARN")
    -- Configure each server
    vim.lsp.config("pyright", {
      flags = { debounce_text_changes = 300 },
      -- your options
    })
    vim.lsp.config("lua_ls", {
      -- settings = { ... },
      flags = { debounce_text_changes = 300 },
    })
    vim.lsp.config("r_language_server", {
      cmd = { "R", "--slave", "-e", "languageserver::run()" },
      filetypes = { "r", "rmd" },
      flags = { debounce_text_changes = 300 },
    })
    vim.lsp.config("marksman", {
      filetypes = { "markdown", "vimwiki" },
      flags = { debounce_text_changes = 300 },
    })
    vim.lsp.config("ltex", {
      autostart = false,
      filetypes = { "markdown", "text" },
      cmd = { "ltex-ls" },
      cmd_env = {
        JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0 -Djdk.xml.entityExpansionLimit=0",
      },
      flags = { debounce_text_changes = 300 },
    })
    vim.lsp.config("clangd", { flags = { debounce_text_changes = 300 } })
    vim.lsp.config("gopls", {
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod" },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern("go.mod", ".git")(fname)
      end,
      flags = { debounce_text_changes = 300 },
    })
    vim.lsp.config("jdtls", { flags = { debounce_text_changes = 300 } })
    -- Enable all valid servers
    vim.lsp.enable({
      "pyright",
      "lua_ls",
      "r_language_server",
      "marksman",
      "ltex",
      -- "clangd",
      -- "gopls",
      "jdtls",
      -- Remove or add more as needed, only if config exists
    })
  end,
}
