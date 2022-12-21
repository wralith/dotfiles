local lspconfig = require('lspconfig')
lspconfig.tsserver.setup({
    filtypes = { 'javascript', 'typescript', 'typescriptreact', 'typescript.tsx' },
})

