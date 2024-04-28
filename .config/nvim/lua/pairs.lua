local M = {}

function M.setup()
  require("plugins").add_plugin({
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
  })
end

return M
