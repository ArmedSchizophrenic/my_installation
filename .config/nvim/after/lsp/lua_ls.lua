return {
  root_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h'),
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
    "main.lua",
  },
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      }, 
      diagnostics = {
       globals = {"vim"}
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("lua", true),
        library = {
          "/home/adrn/.local/share/nvim/lazy/love2d.nvim/love2d",
          "/home/adrn/.local/share/nvim/lazy/love2d.nvim/luasocket",
          },
      },
      telemetry = { enable = false },
    },
  },
}
