local M = {}

M.setup = function()
    require'compe'.setup {
        enabled = true,
        debug = false,
        min_length = 1,

        source = {
            path = true,
            buffer = true,
            vsnip = {filetypes = {'scala', 'html', 'javascript', 'lua', 'java'}},
            nvim_lsp = {
                filetypes = {'scala', 'html', 'javascript', 'lua', 'java'}
            }
        }
    }
end

return M
