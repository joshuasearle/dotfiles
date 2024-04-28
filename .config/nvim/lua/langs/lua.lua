local M = {}

function M.setup()
  require("highlight").add_parser("lua")

  local lsp_settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  }

  require("lsp").add_lsp("lua_ls", lsp_settings)

  local formatter_settings = {
    extra_args = {
      "--indent-type",
      "Spaces",
      "--indent-width",
      "2",
    },
  }

  require("formatting").add_formatter("stylua", formatter_settings)
end

function M.on_attach()
end

return M
