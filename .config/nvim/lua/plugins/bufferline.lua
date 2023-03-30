return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    options = {
      indicator = {
        icon = "",
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          text_align = "left",
          -- hightlight = "Directory",
          separator = true,
        },
      },
      groups = {
        items = {
          require("bufferline.groups").builtin.pinned:with({ icon = "車" }),
        },
      },
    },
  },
}
