local M = {}

function M.setup()
  require("plugins").add_plugin({
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  })
end

return M
