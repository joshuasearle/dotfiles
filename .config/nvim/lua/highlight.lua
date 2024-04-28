local M = {}

M.langs = {}

function M.add_parser(lang)
  M.langs[lang] = true
end

function M.setup()
  require("plugins").add_plugin({
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, _)
      local lang_list = {}
      for lang, _ in pairs(M.langs) do
        table.insert(lang_list, lang)
      end

      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = function(lang, buf)
            -- Only allow explictly enabled languages
            if not M.langs[lang] then return true end

            -- TODO: Extract this logic somewhere else
            -- Only use treesitter for markdown popups
            if lang == "markdown" then
              if vim.api.nvim_buf_get_name(buf) ~= "" then
                return true
              end
            end

            return false
          end,
        },
        indent = { enable = true },
        context_commentstring = { enable = false, enable_autocmd = false },
        ensure_installed = lang_list,
        additional_vim_regex_highlighting = false,
      })
    end,
  })

  require("plugins").add_plugin({
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
  })
end

return M
