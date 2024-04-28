local M = {}

function M.setup()
  require("plugins").add_plugin({
    "akinsho/bufferline.nvim",
    event = { "BufRead", "BufNewFile" },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
      { "]b", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "<leader>`", "<cmd>e #<CR>", desc = "Most recent buffer" },
    },
    opts = {
      options = {
        indicator = {
          icon = "",
        },
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
  })

  require("plugins").add_plugin({
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
    },
  })
end

return M
