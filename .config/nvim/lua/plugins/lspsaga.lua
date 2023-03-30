return {
  "glepnir/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    symbol_in_winbar = {
      enable = false,
    },
    lightbulb = {
      enable = false,
    },
  },
}
