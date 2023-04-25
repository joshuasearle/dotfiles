M = {}

M.keys = {
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

M.opts = {
  suggestion = { enabled = true, auto_trigger = true },
  panel = { enabled = false },
}

return M
