local M = {}

function M.setup()
  local opt = vim.opt

  -- Match indent level of previous line
  opt.autoindent = true

  -- Convert tabs to spaces
  opt.expandtab = true

  -- Tab multiples of shift width
  opt.shiftround = true

  -- Spaces used for autoindent
  opt.shiftwidth = 2

  -- Auto indent based on certain characters
  opt.smartindent = true

  -- Number of spaces for a <Tab>
  opt.tabstop = 2
end

return M
