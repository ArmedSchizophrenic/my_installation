return {
  "S1M0N38/love2d.nvim",
  event = "VeryLazy",
  version = "2.*",
  opts = {},
  keys = {
    { "<leader>v",  ft = "lua",          desc = "LÖVE" },
    { "<leader>vv", "<cmd>LoveRun<cr>",  ft = "lua",   desc = "Run LÖVE" },
    { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua",   desc = "Stop LÖVE" },
  },
  --[[
    config = function ()
    vim.keymap.set("n", "<F5>", function()
  require("snacks").notify("Running Love2D game ▶", { title = "Love2D", level = "info" })

  local project_dir = vim.fn.getcwd()
  local cmd = "love " .. project_dir
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then print(table.concat(data, "\n")) end
    end,
    on_stderr = function(_, data)
      if data then print(table.concat(data, "\n")) end
    end,
    on_exit = function(_, code)
      require("snacks").notify("Love2D exited (" .. code .. ")", { title = "Love2D", level = "warn" })
    end,
  })
end, { noremap = true, silent = true })

  end]]
}
