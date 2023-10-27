lvim.log.level = "warn"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.alpha.active = true
lvim.builtin.illuminate.active = true
lvim.use_icons = true

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

-- plugins
lvim.plugins = {
    -- Colorschemes
    { "shaunsingh/nord.nvim" },
    { "catppuccin/nvim",                name = "catpuccin" },
    { "rose-pine/neovim",               name = "rose-pine" },
    { "olivercederborg/poimandres.nvim" },
    { "folke/tokyonight.nvim",          lazy = "false" },

    -- Visuals
    { "folke/todo-comments.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "xiyaowong/transparent.nvim" },

    -- Lsp realted stuff
    { "fatih/vim-go" },
    { "simrat39/rust-tools.nvim" },
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
    {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function()
            -- copilot assume mapped
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { yaml = true, yml = true }
        end,
    },

    -- Kubernetes
    {
        "someone-stole-my-name/yaml-companion.nvim",
        config = function()
            require("telescope").load_extension("yaml_schema")
            local cfg = require("yaml-companion").setup({
                -- schemas = {
                --     {
                --         name = "Kubernetes 1.22.4",
                --         uri =
                --         "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
                --     },
                -- },
            })
            require("lvim.lsp.manager").setup("yamlls", cfg)
        end
    }
}


-- formatters and linters
local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")
local code_actions = require("lvim.lsp.null-ls.code_actions")

linters.setup {
    { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
}
formatters.setup {
    { command = "prettierd", filetypes = { "typescript", "typescriptreact", "js", "jsx", "html", "markdown", "css" } }
}
formatters.setup {
    { command = "shfmt", filetypes = { "sh" } }
}
code_actions.setup {
    { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
}

-- Emmet
--
local emmet_options = {
    filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "xml",
    },
}

require("lvim.lsp.manager").setup("emmet_ls", emmet_options)


vim.g.go_addtags_transform = "camelcase"

-- turns off LSP semantic tokens by default for nord - treesitter ...
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         client.server_capabilities.semanticTokensProvider = nil
--     end,
-- })

require("todo-comments").setup({})

-- Set indent for 2 for JavaScript files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.svelte" },
    command = "setlocal ts=2 sw=2"
})

-- Spellcheck
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }


lvim.colorscheme = "rose-pine-moon"

lvim.builtin.alpha.dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⡿⣿⢏⡼⠀⢀⣾⢃⣼⠏⢠⡾⠃⣠⠏⠀⠁⣀⠀⡁⠀⠀⣠⡈⠉⡉⠉⢻⡄⠀⠀⠈⠈⢄⠐⣦",
    "⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣯⣾⠃⣼⢁⢠⡿⣡⣾⠃⣴⣿⠁⣠⡟⠀⠄⠡⢀⠈⠀⣠⣱⣿⠇⠡⠄⠀⠀⢿⡆⠈⠄⡁⠈⣳⣽",
    "⠄⠁⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣯⣿⠇⣼⡇⠀⣿⢓⣿⠧⣼⣻⠇⢠⣿⠁⠀⠌⠰⠀⢀⣴⣿⡟⣹⠀⠐⡌⠄⠸⡌⣿⠀⠀⠄⠄⢹⣿",
    "⠄⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣟⣟⢨⣿⠀⣼⣏⣾⡟⣰⣟⣿⢣⣿⡟⠀⠈⢀⢀⣄⣾⣿⡟⣇⣿⣀⡐⣈⡀⠐⣿⢹⡇⠀⠁⠂⢸⣿",
    "⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣻⣹⡇⣯⣿⠀⣿⣿⣿⣿⣿⣼⣧⡟⣽⡃⠀⢈⠈⣭⣿⡿⠃⠉⣿⣿⡍⢉⡏⠙⠻⣿⣼⡷⣬⣶⢷⣿⡟",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢽⣸⡗⣯⣿⢘⣿⢼⣿⣿⣿⣿⣿⢠⣿⠀⠀⣠⡾⣻⣟⣡⣄⡀⣽⡏⣧⢸⡇⠂⠱⢺⣿⣗⡻⣽⣾⣿⠘",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⡿⣷⣹⣿⡞⡿⣸⣿⣿⣿⣿⡏⢸⡿⠀⣰⡿⢣⡿⢻⣿⣿⣷⣿⣥⣿⣾⢡⠀⠐⣾⣿⡝⣧⣿⣿⢹⡀",
    "⠀⠀⠀⠀⢀⣠⣄⣀⣀⣀⣠⣸⣷⣿⣿⣿⢿⣇⠹⣟⡹⠿⡟⠀⠀⣿⣼⠏⢠⠋⠀⣿⣿⣿⣿⣿⣿⠿⣿⡇⠀⢨⣿⣿⡽⣟⡿⠁⢸⠅",
    "⠀⠀⠀⢰⣿⡟⠿⠿⢯⡿⣽⣿⣻⣿⣯⣿⣌⣷⠀⠉⠛⠁⠀⠀⢨⡿⠁⠀⠀⠀⠀⣿⠟⣿⢿⣿⠟⣰⡟⠀⠠⣼⣿⢯⣽⠟⣠⠀⢸⡇",
    "⠀⠀⢠⣿⣻⠃⢠⣄⣤⣔⣃⡀⠉⠉⠙⠛⠻⠾⢧⣤⣤⣤⣤⣀⣈⠀⠀⠀⠀⠀⠀⠙⠿⠶⠞⠁⣰⡿⠁⢀⣽⢻⣿⠟⠁⠀⢹⡄⠐⣿",
    "⡄⠀⣾⣧⡟⠀⣿⡏⠉⠉⠛⠁⢈⣿⠃⠀⠀⠀⢠⣦⡀⢠⣌⡉⠙⠛⠛⠷⠶⠶⠴⣶⣤⣦⣰⣾⡟⠁⢠⡾⢫⣿⡟⠀⠰⠈⢌⣧⠀⢿",
    "⡁⠀⣿⣽⠃⠀⠻⣿⣦⡀⠐⡁⢸⣟⠀⠀⠀⠀⢸⣿⡉⢸⡿⠁⠀⠁⠈⣷⡦⣷⣤⣤⣄⣠⡉⠉⠙⠛⣿⡿⣟⣿⣇⠀⠰⢈⠀⢿⡀⢈",
    "⢶⣴⣿⡟⠀⠀⠀⠀⠛⢿⣦⢀⣿⡟⠶⠶⢶⣦⣿⡇⡘⣿⡇⠀⠀⠀⢀⣿⠁⠀⠉⢹⣿⠛⠛⠋⠀⢠⣿⣗⡣⢿⣿⠀⠐⠠⠀⢸⣷⡀",
    "⣿⢿⣷⡇⠰⢷⣤⣤⣤⣿⢿⣸⣿⠁⠀⠀⠀⢠⣿⢱⢱⣿⠁⠀⠀⠀⣸⣿⠀⠈⡄⣿⡟⠀⠀⠀⠀⣸⣿⣶⢹⣻⣿⡄⠀⡁⠂⠈⣿⣷",
    "⣿⠉⢥⡂⠀⠀⠈⠉⠉⠀⠀⠛⠛⠀⠀⠀⠀⢼⣿⠘⠘⣿⣄⠀⠀⢢⣿⡇⠀⠐⢆⣿⠃⠀⠀⠀⢀⣿⣗⣻⣧⢚⣿⣧⠀⠐⠠⠄⢻⣿",
    "⣿⡀⡸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠿⠛⠋⠀⠀⠀⣸⣿⠀⠀⠐⡏⠹⣿⣧⢏⣷⢫⡜⣿⡆⠀⠃⠌⠘⣟",
    "⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⠆⠀⠀⠀⣀⣀⠀⣁⠀⠀⠂⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠸⣿⠉⠁⢻⣎⢿⡧⡽⣹⣿⡄⠉⠄⠈⢷",
    "⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡟⠀⠀⠀⢀⣿⡏⠂⣿⡿⠿⣶⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡶⠛⠙⣿⡞⣿⡱⣧⣛⣿⡄⠀⠈⠈",
    "⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⢸⣿⠃⢰⣿⠃⢀⡝⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇⠀⠄⣿⣳⢻⣧⡿⡹⡽⣷⡄⠀⠠",
    "⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⣸⡟⠀⣼⣯⣤⣼⣽⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣯⠘⠀⣿⣧⢻⡷⣿⡱⢏⡿⣿⣄⠀",
    "⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣦⣀⣀⣠⣿⠃⢡⣿⡇⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢿⣄⣁⣿⣏⣯⣿⣿⠱⣏⣿⢿⣿⣦",
    "⣶⣶⢦⡤⣤⣄⣀⣀⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠸⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⣬⠿⡻⣍⠯⣹⣿⢇⡿⡜⣿⡇⣿⣿",
    "⠋⠙⠛⠛⢲⠾⢯⣽⣟⣟⣶⡶⢦⣤⣤⣄⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣍⡲⣍⠳⢎⡳⣽⡟⢮⡳⡝⣿⡇⢸⣿",
    "⠀⠀⠀⢀⣀⢀⡉⣴⣮⣉⣉⣹⣟⣿⡯⣭⣿⣻⣯⡿⣟⢳⡶⢤⡤⣤⣀⣀⣀⠀⠀⠀⠀⢰⣟⣛⣛⢳⡹⣎⣶⣿⣹⢣⣛⠵⣻⠆⠸⣿",
}

lvim.builtin.alpha.dashboard.section.footer.val = {
    "Don't worry"
}

lvim.builtin.alpha.dashboard.section.buttons.entries.insert = {
    "Shift + x",
    "󰮢  rm -rf /",
}
