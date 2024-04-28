local M = {}

function M.setup()
  local opt = vim.opt

  -- Set rows for Ctrl-U and Ctrl-D
  opt.scroll = 20

  -- Keep rows above and below cursor
  opt.scrolloff = 10
end

return M
