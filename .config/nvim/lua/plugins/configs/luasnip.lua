M = {}

M.keys = {
  {
    "<tab>",
    function()
      return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    end,
    expr = true,
    silent = true,
    mode = "i",
  },
  {
    "<tab>",
    function()
      require("luasnip").jump(1)
    end,
    mode = "s",
  },
  {
    "<S-tab>",
    function()
      require("luasnip").jump(-1)
    end,
    mode = { "i", "s" },
  },
}

M.opts = {
  history = true,
  delete_check_events = "TextChanged",
}

return M
