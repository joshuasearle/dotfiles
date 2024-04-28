local M = {}

function M.setup()
  local opt = vim.opt

  -- Turn off swap files
  opt.swapfile = false

  -- Use undodir
  opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
  opt.undofile = true
end

return M
