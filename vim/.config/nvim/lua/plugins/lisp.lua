return {
  -- REPL integration for Common Lisp (SWANK) and other lisps.
  -- Connects automatically to a running SWANK server on port 4005.
  -- Start SWANK in SBCL with: (ql:quickload :swank) then (swank:create-server)
  { "Olical/conjure" },

  -- Structural s-expression editing (slurp, barf, wrap, etc.)
  {
    "julienvincent/nvim-paredit",
    config = function()
      require("nvim-paredit").setup()
    end,
  },
}
