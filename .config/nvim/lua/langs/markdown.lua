local M = {}

function M.setup()
  require("highlight").add_parser("markdown")
  require("highlight").add_parser("markdown_inline")
  require("formatting").add_formatter("prettier", {
    filetype = { "markdown" },
  })

  require("plugins").add_plugin({
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  })
end

function M.on_attach()
end

return M
