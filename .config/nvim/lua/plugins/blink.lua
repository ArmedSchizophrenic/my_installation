return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {

    keymap = {
      preset = 'enter',
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
    --  ['CR'] = { 'accept_and_enter' },
      ['<Up>'] = false,
      ['<Down>'] = false,
    },


    appearance = { nerd_font_variant = 'mono' },

    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' }
    },
    snippets = { preset = 'default' },

    fuzzy = { implementation = "prefer_rust" },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" }
}
