local cfg = require("yaml-companion").setup({
  -- Add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"yaml-language-server"}
  -- },
})
local lspconfig = require('lspconfig')
lspconfig.yamlls.setup(cfg)