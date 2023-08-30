return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      -- Mnemonic to remember these:
      -- <leader>d - "d" for DAP
      -- "c" for "continue".
      { "<leader>dc", function() require("dap").continue() end },
      -- "r" for "REPL".
      { "<leader>dr", function() require("dap").repl.open() end },
      -- "tb" for "toggle breakpoint".
      { "<leader>dtb", function() require("dap").toggle_breakpoint() end },
      -- "so" for "step over".
      {"<leader>dso", function() require("dap").step_over() end },
      -- "si" for "step into".
      { "<leader>dsi", function() require("dap").step_into() end },
    },
    config = function()
      local dap = require("dap")

      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run",
          metals = {
            runType = "run",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test File",
          metals = {
            runType = "testFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
    end,
  },
}
