local M = {}

function M.setup()
  require("plugins").add_plugin( {
    "knubie/vim-kitty-navigator",
    config = function()
    end
  })
end

return M
