return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "Issafalcon/neotest-dotnet",
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run closest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Test file",
    },
    {
      "<leader>tp",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "Test project",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop tests",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>tL",
      function()
        require("neotest").run.run_last({ strategy = "dap" })
      end,
      desc = "Run last test in debug mode",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Run test in debug mode",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ short = true, enter = true })
      end,
      desc = "Open test output",
    },
  },
  opts = function()
    return {
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(_)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
        require("neotest-dotnet")({
          dap = { justMyCode = false },
        }),
      },
      icons = {
        passed = " ",
        running = " ",
        failed = " ",
        unknown = " ",
        running_animated = vim.tbl_map(function(s)
          return s .. " "
        end, { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }),
      },
      output = {
        open_on_run = false,
      },
    }
  end,
}
