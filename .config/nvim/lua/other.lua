local M = {}

function M.setup()
  local opt = vim.opt

  -- Backspace
  --[[
  indent:
  Allows deletion of indents created by `autoindent`.

  eol:
  Allows deletion of line breaks.

  start:
  Allows deletion of characters not inserted in current insert session.
  If no space between old text and text from current insert session,
  Ctrl-W and Ctrl-U will stop where old text begins,
  as if an imaginary space was added inbetween.

  nostop:
  Same as `start`, but doesn't stop deleting on Ctrl-W and Ctrl-U,
  which is the more intuitive behaviour, but less powerful.
  --]]
  opt.backspace = "indent,start"

  -- Clipboard
  --[[
  unnamed uses * register as clipboard
  unnamedplus uses + register as clipboard and changes operations to use that register
  --]]
  opt.clipboard = "unnamedplus"

  -- Automatically add newline at bottom
  opt.fixendofline = true

  -- Show incremental changes of substitute command
  opt.inccommand = "split"

  -- Show incremental matches of searches
  opt.incsearch = true

  -- Show ghost chars for trailing characters
  opt.list = true
  opt.listchars = { trail = ".", tab = ">>" }

  -- Choose messages to display
  opt.shortmess = "filmnrwxaoOstTWAIcCqFS"
  opt.report = 999

  -- Move to start of line on certain movements
  opt.startofline = true

  vim.g.netrw_silent = 1

  vim.cmd([[filetype plugin off]])

  opt.wrap = false
end

return M
