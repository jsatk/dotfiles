return {
  { 
    "tpope/vim-rhubarb",
    config = function(_, _)
      vim.g["github_enterprise_urls"] = { "https://code.corp.creditkarma.com" }
    end
  },
}
