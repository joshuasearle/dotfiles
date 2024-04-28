local M = {}

function M.setup()
  require("plugins").add_plugin({
    "shortcuts/no-neck-pain.nvim",
    opts = {
      autocmds = {
        -- enableOnVimEnter = true,
        -- enableOnTabEnter = true,
      },
    },
    -- Load plugin on startup
    lazy = false,
    keys = {
      {
        "<leader>z",
        function()
          require("no-neck-pain").toggle()
        end,
        desc = "Center buffer",
      },
    },
  })
end

return M
