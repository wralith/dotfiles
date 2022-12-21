local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
    cmd = { 'gopls', 'serve' },
    filtypes = { 'go', 'go.mod' },
})
