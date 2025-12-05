return {
  'mrcjkb/rustaceanvim',

  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  version = '^6',
  lazy = false,
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        inlay_hints = {
          auto = true,
        }
      },

      server = {
        cmd = { "rustup", "run", "stable", "rust-analyzer" },

        on_attach = function(client, bufnr) 
          
        end,
      },

      dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(
          "/home/adrn/.local/bin/codelldb",
          "/usr/lib/liblldb.so"
        )
      },
    }

    local dap = require("dap")
    local function notify(msg, level)
      require("snacks").notify(msg, {
        title = "Rust Debug",
        level = level or "info",
      })
    end

    dap.listeners.after.event_initialized["snacks_notify"] = function()
      notify("Debugging started 🚀")
    end

    dap.listeners.after.event_stopped["snacks_notify"] = function(_, body)
      notify("Stopped: " .. (body.reason or "breakpoint"), "warn")
    end

    dap.listeners.before.event_terminated["snacks_notify"] = function()
      notify("Debug session terminated 🛑")
    end

    dap.listeners.before.event_exited["snacks_notify"] = function()
      notify("Debug session exited ✔")
    end
    dap.adapters.rust = require("rustaceanvim.config").get_codelldb_adapter(
      "/usr/sbin/codelldb",
      "/usr/lib/liblldb.so"
    )

    dap.configurations.rust = {
      {
        name = "Debug executable",
        type = "rust",
        request = "launch",
        program = function()
          -- Pobiera katalog projektu
          local cwd = vim.fn.getcwd()
          -- Pobiera nazwę ostatniego folderu (nazwa projektu)
          local project_name = vim.fn.fnamemodify(cwd, ":t")
          -- Zwraca pełną ścieżkę do binarki w target/debug
          return cwd .. "/target/debug/" .. project_name
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
  end
}
