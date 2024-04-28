local M = {}

function M.setup()
  local opt = vim.opt

  -- Case sensitive searching if capital
  opt.smartcase = true

  -- Search highlighting
  opt.hlsearch = true

  -- Ingore case in searching
  opt.ignorecase = true

  -- Show incremental matches of searches
  opt.incsearch = true
end

return M
