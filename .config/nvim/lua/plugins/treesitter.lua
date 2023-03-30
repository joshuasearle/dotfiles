return {
  "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<C-Space>", false },
  },
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@diagnostic disable-next-line: missing-parameter
      vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
    end
  end,
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        disable = function(lang, buf)
          print(vim.api.nvim_buf_get_name(buf))
          -- Only use treesitter for markdown popups
          if lang == "markdown" and vim.api.nvim_buf_get_name(buf) ~= "" then
            return true
          end

          return false
        end
      },
    })
  end,
}
