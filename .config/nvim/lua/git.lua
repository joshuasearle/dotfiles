local M = {}

function M.setup()

  require("plugins").add_plugin({
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    keys = {
      {
        "]h",
        desc = "Next hunk",
        mode = "n",
      },
      {
        "[h",
        desc = "Prev hunk",
        mode = "n",
      },
      {
        "<leader>ghs",
        desc = "Stage hunk",
        mode = "n",
      },
      {
        "<leader>ghr",
        desc = "Reset hunk",
        mode = "n",
      },
      {
        "<leader>ghS",
        desc = "Stage buffer",
        mode = "n",
      },
      {
        "<leader>ghu",
        desc = "Undo stage hunk",
        mode = "n",
      },
      {
        "<leader>ghR",
        desc = "Reset buffer",
        mode = "n",
      },
      {
        "<leader>ghp",
        desc = "Preview hunk",
        mode = "n",
      },
      {
        "<leader>ghb",
        desc = "Blame line",
        mode = "n",
      },
      {
        "<leader>ghd",
        desc = "Diff this",
        mode = "n",
      },
      {
        "<leader>ghD",
        desc = "Diff this ~",
        mode = "n",
      },
      {
        "ih",
        desc = "GitSigns select hunk",
        mode = "o",
      },
      {
        "ih",
        desc = "GitSigns select hunk",
        mode = "x",
      },
    },
  })
end

return M
