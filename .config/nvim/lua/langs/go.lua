local M = {}

function M.setup()
  require("highlight").add_parser("go")
  require("highlight").add_parser("gomod")
  require("highlight").add_parser("gosum")

  require("lsp").add_lsp("gopls")

  require("formatting").add_formatter("gofmt")

  require("test").add_adapter("nvim-neotest/neotest-go", {
    experimental = {
      test_table = true,
    },
    args = { "-count=1", "-timeout=60s" },
  })

  require("debugger").add_adapter("delve", {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  })
  require("debugger").add_configuration("go", {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  })
  require("debugger").add_configuration("go", {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  })
end

function M.on_attach()
  local opt = vim.opt

  opt.expandtab = false
  opt.listchars = { trail = ".", lead = ".", tab = "  " }
end

return M
