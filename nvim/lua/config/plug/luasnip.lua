ls = require("luasnip")
ls.config.set_config({
	history = true, -- keep around last snippet local to jump back
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/nvim//lua/snippets" } })
