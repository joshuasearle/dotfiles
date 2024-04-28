local M = {}

function M.setup()
  local opt = vim.opt

  -- Automatically write file on certain operations
  opt.autowriteall = true

  -- Auto confirm
  opt.confirm = false

  require("plugins").add_plugin({
    "Pocco81/auto-save.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      execution_message = {
        message = function() return "" end,
      },
    }
  })
end

return M
