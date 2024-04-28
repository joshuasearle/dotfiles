local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local M = {}

function M.setup()
  -- Centering
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
  map("n", "{", "{zz", { desc = "Previous paragraph" })
  map("n", "}", "}zz", { desc = "Next paragraph" })
  map("n", "N", "Nzz", { desc = "Prevoius item" })
  map("n", "n", "nzz", { desc = "Next item" })

  -- Window resize
  map("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
  map("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

  -- Visual mode indenting
  map("v", "<", "<gv", { silent = true, desc = "Unindent selection" })
  map("v", ">", ">gv", { silent = true, desc = "Indent selection" })

  -- Completion
  --[[
  If pop-up menu is visible, exit with `<C-e`> and then insert newline with `<CR>`.
  If no pop-up menu is visible, insert newline with `<CR>`.
  --]]
  map("i", "<CR>", "pumvisible() ? '<C-e><CR>' : '<CR>'", { expr = true, silent = true })

  require("plugins").add_plugin( {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      local wk = require("which-key")

      wk.setup()

      wk.register({
        c = { name = "Code" },
        b = { name = "Buffers" },
        f = { name = "Find" },
        d = { name = "Debug" },
        t = { name = "Test" },
        g = { name = "Git" },
      }, { prefix = "<leader>" })
    end,
  })
end

return M
