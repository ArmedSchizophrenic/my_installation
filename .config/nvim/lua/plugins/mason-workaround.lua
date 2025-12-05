return {
  {
    "mason-org/mason.nvim", version = "~1.0.0",
  },
  {
    "mason-org/mason-lspconfig.nvim", version = "~1.0.0",
    config = function ()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_enable = false
      }
    end
  }
}
