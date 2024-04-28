local keys = {
  {
    "<C-CR>",
    function()
      require("copilot.suggestion").accept()
    end,
    desc = "Accept suggestion",
    mode = "i",
  },
  {
    "<C-S-CR>",
    function()
      require("copilot.suggestion").accept_line()
    end,
    desc = "Accept line",
    mode = "i",
  },
  {
    "<C-BS>",
    function()
      require("copilot.suggestion").dismiss()
    end,
    desc = "Dismiss suggestion",
    mode = "i",
  },
  {
    "<C-S-[>",
    function()
      require("copilot.suggestion").prev()
    end,
    desc = "Previous suggestion",
    mode = "i",
  },
  {
    "<C-S-]>",
    function()
      require("copilot.suggestion").next()
    end,
    desc = "Next suggestion",
    mode = "i",
  },
}

local opts = {
  suggestion = { enabled = true, auto_trigger = true },
  panel = { enabled = false },
}

local M = {}

function M.setup()
  require("plugins").add_plugin({
    "zbirenbaum/copilot.lua",
    event = { "BufReadPre", "BufNewFile" },
    build = ":Copilot auth",
    keys = keys,
    opts = opts,
  })
end

return M
