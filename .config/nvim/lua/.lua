local M = {}

function M.setup()

  require("plugins").add_plugin({
    "mfussenegger/nvim-dap",
  })
end

return M
