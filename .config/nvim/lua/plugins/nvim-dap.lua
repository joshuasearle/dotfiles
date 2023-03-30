return {
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
  },
  config = function()
    local dap = require("dap")

    vim.g.dotnet_build_project = function()
      local default_path = vim.fn.getcwd() .. "/"
      if vim.g["dotnet_last_proj_path"] ~= nil then
        default_path = vim.g["dotnet_last_proj_path"]
      end
      local path = vim.fn.input("Path to your *proj file", default_path, "file")
      vim.g["dotnet_last_proj_path"] = path
      local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
      print("")
      print("Cmd to execute: " .. cmd)
      local f = os.execute(cmd)
      if f == 0 then
        print("\nBuild: ✔️ ")
      else
        print("\nBuild: ❌ (code: " .. f .. ")")
      end
    end

    vim.g.dotnet_get_dll_path = function()
      local request = function()
        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end

      if vim.g["dotnet_last_dll_path"] == nil then
        vim.g["dotnet_last_dll_path"] = request()
      else
        if
          vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
          == 1
        then
          vim.g["dotnet_last_dll_path"] = request()
        end
      end

      return vim.g["dotnet_last_dll_path"]
    end

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
            vim.g.dotnet_build_project()
          end
          return vim.g.dotnet_get_dll_path()
        end,
      },
    }

    dap.adapters.netcoredbg = {
      type = "executable",
      command = "/usr/local/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }

    dap.adapters["pwa-node"] = function(on_config, config, parent)
      local target = config["__pendingTargetId"]
      if target and parent then
        local adapter = parent.adapter --[[@as ServerAdapter]]
        on_config({
          type = "server",
          host = "localhost",
          port = adapter.port,
        })
      else
        on_config({
          type = "server",
          host = "localhost",
          port = "8123",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = { "/Users/Josh.Searle/Downloads/js-debug/src/dapDebugServer.js", "${port}" },
          },
        })
      end
    end
  end,
}
