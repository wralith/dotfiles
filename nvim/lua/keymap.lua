local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local function unmap(mode, bind)
	vim.api.nvim_del_keymap(mode, bind)
end

local opt = {} --empty opt for maps with no extra options
local M = {}

--[[
    MAPPING:
	map takes 4 args:
		The first is the type, whether in all, normal, insert etc. (reference: https://github.com/nanotee/nvim-lua-guide#defining-mappings)
		The Second Arg is the keybind. Just like normal vim way
		The Third is the command to execute
		The Fourth is other extra options
	Example:  (toggles line numbers)
		map("n", "<C-n>", ":set rnu!<CR>", opt)
--]]
--
-- {{{ move lines
map('n', '<A-j>', ':m .+1<CR>==', opt)
map('n', '<A-k>', ':m .-2<CR>==', opt)
map('i', '<A-j>', '<Esc>:m .+1<CR>==', opt)
map('i', '<A-k>', '<Esc>:m .-2<CR>==', opt)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opt)
map('v', '<A-k>', ":m '>-2<CR>gv=gv", opt)
-- }}}

-- {{{ Umapping
--unmap('n', '<leader>f')
-- }}}

-- {{{ misc bindings
vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ','
map('n', '<C-n>', ':set rnu!<CR>', opt) -- toggle relative line numbers
map('', '<C-/>', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('', '<leader>e', ':NvimTreeToggle<CR>', opt) -- toggle nvimtree
map('n', '<leader>nf', ':Neoformat<CR>', { noremap = true }) -- format current buffer with neoformat
map('n', '<leader>nb', ':hi Normal guibg=NONE ctermbg=NONE<CR>', opt) -- remove background color
map('n', '<leader>nv', ':hi NonText guibg=NONE ctermbg=NONE<CR>', opt) -- remove non text background color
map('n', '<leader>~', ':Dashboard<CR>', opt) -- map show dashboard
map('n', '<leader>dd', '<cmd> lua vim.diagnostic.open_float() <CR>',opt) -- shows diagnostics in float
map('n', '<leader>df', '<cmd> lua vim.lsp.buf.hover()<CR>',opt) -- shows diagnostics in float

-- clipboard mappings
map('n', '<leader>ya', ':%y+<CR>', opt) -- Copy content of entire buffer to system clipboard
map('n', '<leader>yl', '"+yy', opt) -- yank current line into system clipboard

-- write buffer changes
map('n', 'WW', ":w<CR>", opt)
-- }}}

-- {{{ autocompletion mappings for cmp
local cmp = require('cmp')
M.cmp_mappings = {

	['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
}
-- }}}

-- {{{ gitsigns mappings
M.gitsigns_mappings = {
	noremap = true,
	['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
	['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

	['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
	['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
	['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
	['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
	['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
	['n <leader>gS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
	['n <leader>gU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

	-- Text objects
	['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
}
-- }}}

-- {{{ buffer management
map('n', '<leader>bh', ':bf<CR>', { noremap = true })
map('n', '<leader>bk', ':bn<CR>', { noremap = true })
map('n', '<leader>bj', ':bp<CR>', { noremap = true })
map('n', '<leader>bl', ':bl<CR>', { noremap = true })
map('n', '<leader>bd', ':bd<CR>', { noremap = true })
-- }}}

-- {{{ window navigation
map('n', '<leader>h', ':wincmd h<CR>', opt)
map('n', '<leader>j', ':wincmd j<CR>', opt)
map('n', '<leader>k', ':wincmd k<CR>', opt)
map('n', '<leader>l', ':wincmd l<CR>', opt)
-- }}}

-- {{{ terminal commands
map('n', '<leader><CR>', ':vs | terminal<CR>i', opt)
map('n', '<leader>\\', ':sp | terminal<CR>i', opt)
map('t', '<C-esc>', '<C-\\><C-n>', opt)
-- }}}

-- {{{ telescope pullup
map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
map('n', '<leader>fg', ':Telescope git_commits<CR>', { noremap = true })
map('n', '<leader>fG', ':Telescope git_branches<CR>', { noremap = true })
map('n', '<leader>fe', ':lua require(\'telescope.builtin\').symbols({ sources = { \'kaomoji\'}})<CR>', { noremap = true })
map('n', '<leader>fy', ':Telescope yaml_schema<CR>', {noremap = true})
-- }}}

-- {{{ hop.nvim
map('n', '<leader>ah', ':HopWord<CR>', opt)
map('n', '<leader>ak', ':HopWordBC<CR>', opt)
map('n', '<leader>aj', ':HopWordAC<CR>', opt)
map('n', '<leader>al', ':HopWordMW<CR>', opt)
map('n', '<leader>ac', ':HopChar1<CR>', opt)
map('n', '<leader>aC', ':HopChar2<CR>', opt)
map('n', '<leader>ag', ':HopPattern<CR>', opt)
map('n', '<leader>an', ':HopLineStart<CR>', opt)
map('n', '<leader>af', ':HopWordCurrentLine<CR>', opt)
-- }}}

map('n', '<leader>s', ':Telescope buffers<CR>', opt)

-- returns any externally-required keymaps for usage
return M
