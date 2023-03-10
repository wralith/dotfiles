--[[ local cmp = require('cmp')
local keymap = require('keymap')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['UltiSnips#Anon'](args.body)
		end,
	},
	mapping = keymap.cmp_mappings,
	sources = cmp.config.sources({
		{ name = 'nvim_lsp', priority = 1 },
		{ name = 'nvim_lsp_signature_help' },
		-- { name = 'ultisnips' },
		{ name = 'buffer' },
		{ name = 'path' },
	}),
})
--]]
