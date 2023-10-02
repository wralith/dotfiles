lvim.log.level = "warn"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.alpha.active = true
lvim.builtin.illuminate.active = true
lvim.use_icons = false

lvim.builtin.indentlines.active = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
lvim.leader = "space"

-- custom keymaps
lvim.keys.normal_mode["<leader>bd"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<leader>t"] = ":TransparentToggle<CR>"
lvim.keys.normal_mode["K"] = ":lua vim.lsp.nuf.hover()<CR>"

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 90

lvim.builtin.treesitter.highlight.enable = true

local luasnip = require("luasnip")
local cmp = require("cmp")

-- plugins
lvim.plugins = {
    -- Colorschemes
    { "shaunsingh/nord.nvim" },
    { "catppuccin/nvim",            name = "catpuccin" },
    { "rose-pine/neovim",           name = "rose-pine" },

    -- Visuals
    { "folke/todo-comments.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "xiyaowong/transparent.nvim" },

    -- Lsp realted stuff
    { "fatih/vim-go" },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".on_attach({
                bind = true,
                toggle_key = "<C-s>",
                hint_prefix = " ",
                floating_window = false,
            })
        end
    },

    -- Utilities
    {
        "phaazon/hop.nvim",
        name = "hop",
        keys = { "s", "S" },
        config = function()
            require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
            vim.api.nvim_set_keymap("n", "s", ":HopWord<CR>", {})
            vim.api.nvim_set_keymap("n", "S", ":HopPattern<CR>", {})
        end
    },

    -- AI
    {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function()
            -- copilot assume mapped
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_tab_fallback = ""
        end,
    },
    {
        "hrsh7th/cmp-copilot",
        config = function()
lvim.builtin.cmp.mapping["Tab"] = cmp.mapping(function(fallback)
    local copilot_keys = vim.fn['copilot#Accept']()
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
    else
        fallback()
    end
end, {
    'i',
    's',
})
        end,
    },
}

-- formatters and linters
local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")
local code_actions = require("lvim.lsp.null-ls.code_actions")

linters.setup {
    { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
}
formatters.setup {
    { command = "prettierd", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
}
code_actions.setup {
    { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
}


-- turns off LSP semantic tokens by default for nord - treesitter ...
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

require("todo-comments").setup({})

-- Set indent for 2 for JavaScript files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.svelte" },
    command = "setlocal ts=2 sw=2"
})

-- Spellcheck
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }


lvim.colorscheme = "nord"
