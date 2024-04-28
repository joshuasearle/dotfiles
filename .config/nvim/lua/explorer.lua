local M = {}

function M.setup()
  local plugins = require("plugins");

  plugins.add_plugin( {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      {
        "<leader>o",
        function()
          require("oil").open()
        end,
        desc = "File explorer",
      },
    }
  })
end

return M
