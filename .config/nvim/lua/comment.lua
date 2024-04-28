local M = {}

function M.setup()
  -- Disable comment auto formatting
  vim.opt.formatoptions = ""

  require("plugins").add_plugin( {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {},
  })
end

return M
