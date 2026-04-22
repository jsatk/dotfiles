return {
  -- Full-featured Common Lisp development: REPL, debugger with restarts,
  -- inspector, XREF. Connects via Swank on port 4005.
  -- Start SWANK in SBCL: (ql:quickload :swank) then (swank:create-server)
  {
    "vlime/vlime",
    ft = { "lisp" },
    init = function()
      -- vlime's vim plugin lives in the vim/ subdirectory of the repo
      vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/vlime/vim")
      vim.g.vlime_cl_impl = "ros"
      vim.g.vlime_enable_autodoc = true
      vim.cmd([[
        function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
          return ['ros', 'run', '--load', a:vlime_loader, '--eval', a:vlime_eval]
        endfunction
      ]])
    end,
  },

  -- Structural s-expression editing (slurp, barf, wrap, etc.)
  {
    "julienvincent/nvim-paredit",
    config = function()
      require("nvim-paredit").setup()
    end,
  },
}
