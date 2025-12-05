return
{
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config["rust-analyzer"] = {
       cmd = { "rustup", "run", "stable", "rust-analyzer" },
   --   root_dir = vim.fn.expand("%:p:h"),
      filetypes = { "rs", "rust" },
      root_markers = { "main.rs" },
    }
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("rust-analyzer")
  end
}
