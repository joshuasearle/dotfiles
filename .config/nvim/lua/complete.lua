local M = {}

function M.setup()
  local opt = vim.opt

  -- Things to include in completion menu
  opt.complete = ".,w,b,u,t"

  -- Completions options
  --[[
  menu:
  Brings up menu if more than one option.

  menuone:
  Brings up menu even if only one options.

  longest:
  Autocompletes to longest common prefix of options.

  preview:
  ???

  noinsert:
  Don't insert text until user selects option.

  noselect:
  Don't initially select an option.
  --]]
  opt.completeopt = "menuone,longest,preview,noselect"

  -- Wildmode menu options
  opt.wildmode = "longest:full"

  require("plugins").add_plugin({
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")

      return {
        completion = {
          completeopt = "menuone,longest,preview,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
              cmp.complete()
            end
          end,
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
  })
end

return M
