local M = {}

M.formatter_configs = {}

function M.add_formatter(name, config)
  config = config or {}
  table.insert(M.formatter_configs, { name, config })
end

function M.setup()
  local plugins = require("plugins")

  plugins.add_plugin({
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua" },
        automatic_installation = true,
      })
    end,
  })

  plugins.add_plugin({
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      local sources = {}

      for _, formatter_config in pairs(M.formatter_configs) do
        local name = formatter_config[1]
        local config = formatter_config[2]

        table.insert(sources, null_ls.builtins.formatting[name].with(config))
      end

      null_ls.setup({ sources = sources })
    end,
    keys = {
      {
        "<leader>cf",
        vim.lsp.buf.format,
        desc = "Format document",
        mode = "v",
      },
      {
        "<leader>cf",
        vim.lsp.buf.format,
        desc = "Format document",
        mode = "n",
      },
    },
  })
end

return M
