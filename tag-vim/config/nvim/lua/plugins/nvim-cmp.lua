return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local auto_select = true
      opts.mapping = cmp.mapping.preset.insert(vim.tbl_deep_extend("force", opts.mapping, {
        ["<Tab>"] = LazyVim.cmp.confirm({ select = auto_select }),
      }))
    end,
  },
}
