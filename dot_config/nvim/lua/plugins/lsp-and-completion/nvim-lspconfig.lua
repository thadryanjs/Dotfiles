-- lua/plugins/lsp-and-completion/nvim-lspconfig.lua
--
-- LSP servers ONLY. This file no longer touches completion behaviour --
-- coq_nvim is the single completion engine now.
--
-- Two changes from before:
--   1. The `LspAttach` + `vim.lsp.completion.enable` block is GONE. Running
--      native completion alongside coq was the two-engines-fighting problem.
--   2. coq's capabilities are injected into every server via the "*" config,
--      so LSP-sourced completions flow through coq's popup.

return {
  "neovim/nvim-lspconfig",
  dependencies = { "ms-jpq/coq_nvim" }, -- ensure coq is available when we read its capabilities
  config = function()
    vim.lsp.log.set_level("WARN")

    -- Give every server coq's completion capabilities.
    -- If `require("coq")` errors here (version mismatch), comment this block
    -- out -- path completion still works without it, LSP completions may look
    -- slightly thinner.
    local ok, coq = pcall(require, "coq")
    if ok and coq.lsp_ensure_capabilities then
      vim.lsp.config("*", {
        capabilities = coq.lsp_ensure_capabilities().capabilities,
      })
    end

    -- Per-server config
    vim.lsp.config("pyright", {
      flags = { debounce_text_changes = 300 },
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local markers = {
          "pyrightconfig.json", "pyproject.toml", "setup.py",
          "setup.cfg", "requirements.txt", "Pipfile", ".git",
        }
        -- walk up from the file looking for a project marker
        local found = vim.fs.root(bufnr, markers)
        -- fall back to the file's own directory instead of leaving root = nil
        on_dir(found or vim.fs.dirname(fname))
      end,
    })
    vim.lsp.config("lua_ls", {
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

    -- Enable servers
    vim.lsp.enable({
      "pyright",
      "lua_ls",
      "r_language_server",
      "marksman",
      "ltex",
      -- "clangd",
      -- "gopls",
      "jdtls",
    })

    -- NOTE: the old native-completion autocmd was removed on purpose.
    -- coq_nvim handles all completion now (see coqnvim.lua).
  end,
}
