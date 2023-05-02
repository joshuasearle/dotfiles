return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      require("plugins.lsp.lspconfig")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          }),
          nls.builtins.formatting.csharpier,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.black,
        },
      }
    end,
  },

  {
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
  },
}
