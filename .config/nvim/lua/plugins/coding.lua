return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = require("plugins.configs.luasnip").opts,
    keys = require("plugins.configs.luasnip").keys,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    opts = require("plugins.configs.cmp").opts,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {},
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "BufReadPre", "BufNewFile" },
    build = ":Copilot auth",
    keys = require("plugins.configs.copilot").keys,
    opts = require("plugins.configs.copilot").opts,
  },

  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
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
          -- netcoredbg needs special strategy
          if vim.bo.filetype == "cs" then
            require("neotest").run.run({
              strategy = require("neotest-dotnet.strategies.netcoredbg"),
              is_custom_dotnet_debug = true,
            })
          else -- for all others, use regular dap strategy
            require("neotest").run.run({ strategy = "dap" })
          end
        end,
        -- function()
        --   require("neotest").run.run({ strategy = "dap" })
        -- end,
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
  },

  {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue to next breakpoint" },
      { "<leader>di", "<cmd>DapStepInto<CR>", desc = "Step into" },
      { "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step over" },
      { "<leader>dO", "<cmd>DapStepOut<CR>", desc = "Step out" },
      { "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Stop debugging" },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Stop debugging",
      },
    },
    config = function()
      require("dapui").setup()

      local dap = require("dap")

      dap.adapters.netcoredbg = {
        type = "executable",
        command = "/usr/local/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "netcoredbg",
          name = "Launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }
    end,
  },
}
