local lspconfig = require('lspconfig')
lspconfig.tsserver.setup({
	root_dir = lspconfig.util.root_pattern('package.json'),
	single_file_support = false,
})

lspconfig.eslint.setup({
	root_dir = lspconfig.util.root_pattern('package.json'),
})

lspconfig.denols.setup({
	root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
	init_options = {
		lint = true,
	},
})

