-- This is bugged but there is a workaround
-- cd ~/.local/share/nvim/lazy/markdown-preview.nvim
-- yarn add tslib
return {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
}
