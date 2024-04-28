local M = {}

function M.setup()
  require("highlight").add_parser("python")

  require("lsp").add_lsp("pyright")

  require("formatting").add_formatter("black")
end

function M.on_attach()
end

return M
