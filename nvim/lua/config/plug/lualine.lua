-- lualine setup config
require('lualine').setup({
	options = {

		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		theme = lualine_theme,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})