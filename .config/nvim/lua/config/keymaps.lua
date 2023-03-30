-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

vim.g.kitty_navigator_no_mappings = 1

map("n", "<C-h>", ":KittyNavigateLeft<CR>", { desc = "Go to left window", silent = true })
map("n", "<C-j>", ":KittyNavigateDown<CR>", { desc = "Go to bottom window", silent = true })
map("n", "<C-k>", ":KittyNavigateUp<CR>", { desc = "Go to top window", silent = true })
map("n", "<C-l>", ":KittyNavigateRight<CR>", { desc = "Go to right window", silent = true })

-- Centering
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Unbind these as I have these binds in tmux
map("n", "<C-Up>", "")
map("n", "<C-Down>", "")
map("n", "<C-Left>", "")
map("n", "<C-Right>", "")

-- Window resize
map("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Copilot
map("i", "<C-CR>", "<cmd>Copilot suggestion accept<CR>", { silent = true, desc = "Accept Copilot suggestion" })
map("i", "<C-S-CR>", "<cmd>Copilot suggestion accept_line<CR>", { silent = true, desc = "Accept Copilot line" })
map("i", "<C-]>", "<cmd>Copilot suggestion next<CR>", { silent = true, desc = "Next Copilot suggestion" })
map("i", "<C-[>", "<cmd>Copilot suggestion prev<CR>", { silent = true, desc = "Previous Copilot suggestion" })
map("i", "<C-\\>", "<cmd>Copilot suggestion dismiss<CR>", { silent = true, desc = "Dismiss Copilot suggestion" })

-- Completion
map("i", "<CR>", "pumvisible() ? '<C-e><CR>' : '<CR>'", { expr = true, silent = true })
