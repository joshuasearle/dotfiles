local opt = vim.opt

-- Cursor
opt.cursorline = true
opt.guicursor = ""

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Line wrapping
opt.wrap = false

-- Backups
opt.backup = false
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- Splitting
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Saving
opt.autowrite = true
opt.confirm = true

-- Completion
--[[
menuone: always show menu, even when only one autocomplete option
preview: show preview menu if extra info
noselect: initially, have no options selected
longest: if all options have common prefix, update word to include that common prefix 
--]]
opt.completeopt = "menuone,preview,noselect,longest"

-- Formatting
-- `:h fo-table`
-- Option gets overwritten in file type pluings, so this auto command  fixes it
vim.cmd([[
  augroup NoAutoComment
    au!
    au FileType * setlocal formatoptions-=cro
  augroup end
]])

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Status bar
opt.laststatus = 0

-- Popups
opt.pumblend = 10
opt.pumheight = 16

-- Trailing whitespace
opt.list = true
opt.listchars = { trail = "·" }

-- Messages
opt.shortmess:append({ W = true, I = true, c = true })

-- Command autocomplete
opt.wildmode = "longest:full"

-- Miscellaneous
opt.scrolloff = 12
opt.sidescrolloff = 8
-- opt.spelllang = { "en" }
opt.signcolumn = "yes"
opt.updatetime = 50
opt.colorcolumn = "80"
opt.backspace = "indent,eol,start"
opt.conceallevel = 3
opt.inccommand = "nosplit"
opt.timeoutlen = 600
opt.winminwidth = 5
opt.showmode = false

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-- Always newline at end of file
opt.fixendofline = true
