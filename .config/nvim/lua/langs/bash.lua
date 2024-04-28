local M = {}

M.pattern = "sh"

function M.setup()
  require("highlight").add_parser("bash")
  require("lsp").add_lsp("bashls")
  require("formatting").add_formatter("shfmt", {
    extra_args = {
      "--indent",
      "2",
      "--case-indent",
      "--space-redirects",
      "--binary-next-line",
    },
  })
end

function M.on_attach()
  -- print("starting bash-language-server...")
  -- vim.lsp.start({
  --   name = "bash-language-server",
  --   cmd = { "bash-language-server", "start" },
  -- })
end

return M
