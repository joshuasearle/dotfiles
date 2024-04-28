local M = {}

function M.setup()
  require("highlight").add_parser("yaml")
  require("formatting").add_formatter("prettierd", {
    filetypes = { "yaml" },
  })
end

function M.on_attach()
end

return M
