lvim.log.level = "info"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
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

vim.opt.shell = "/bin/sh"

lvim.builtin.treesitter.highlight.enable = true

-- hover remove borders
lvim.builtin.cmp.window = {
    completion = {
    },
}

lvim.builtin.project.patterns = { ".git", "package.json", "go.mod" }

-- plugins
lvim.plugins = {
    -- Colorschemes
    -- { "williamboman/mason-lspconfig.nvim"},
    { "shaunsingh/nord.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "catppuccin/nvim",                name = "catpuccin" },
    { "rose-pine/neovim",               name = "rose-pine" },
    { "neanias/everforest-nvim" },
    { "folke/tokyonight.nvim" },
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

    -- Debug
    { "mfussenegger/nvim-dap" },
    { "leoluz/nvim-dap-go" },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },

    -- MOST IMPORTANT PLUGIN EVER
    {
        "giusgad/pets.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
        config = function()
            require("pets").setup({
                row = 4,
                popoup = {
                    width = "10%",
                    avoid_statusline = true
                }

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
    -- {
    --     "github/copilot.vim",
    --     event = "VeryLazy",
    --     config = function()
    --         -- copilot assume mapped
    --         vim.g.copilot_assume_mapped = true
    --         vim.g.copilot_no_tab_map = true
    --         vim.g.copilot_filetypes = { yaml = true, yml = true }
    --         -- require("copilot").setup({
    --         --     keys: {
    --         --         ac
    --         --     }
    --         -- })

    --     end,
    -- },
    -- Kubernetes
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                },
            })
        end
    },
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
    },
    {
        "L3MON4D3/LuaSnip",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
            region_check_events = "CursorMoved",
        },
    }
}

-- copilot
--
-- table.insert(lvim.plugins, {
--     "zbirenbaum/copilot-cmp",
--     event = "InsertEnter",
--     dependencies = { "zbirenbaum/copilot.lua" },
--     config = function()
--         vim.defer_fn(function()
--             require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
--             require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
--         end, 100)
--     end,
-- })


-- dap
--
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
    return
end

dapgo.setup()


-- formatters and linters
local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")
local code_actions = require("lvim.lsp.null-ls.code_actions")

linters.setup {
    { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
}
formatters.setup {
    {
        command = "prettierd",
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "html", "markdown", "css", "json" }
    }
}
formatters.setup {
    { command = "shfmt", filetypes = { "sh" } }
}

formatters.setup({
    { command = "black", filetypes = { "python" } }
})

code_actions.setup {
    { command = "eslint", filetypes = { "typescript", "typescriptreact", "js", "jsx" } }
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
        "templ"
    },
}

-- Tailwind for CVA
require 'lspconfig'.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
                },
            },
        },
    },
})

require 'lspconfig'.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

require 'lspconfig'.htmx.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

require("lvim.lsp.manager").setup("emmet_ls", emmet_options)

-- Post-CSS
require("lvim.lsp.manager").setup("cssls", {
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
        scss = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
        less = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
    },
})


vim.g.go_addtags_transform = "camelcase"

-- turns off LSP semantic tokens by default for nord - treesitter ...
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
--
vim.filetype.add({ extension = { templ = "templ" } })

require("todo-comments").setup({})

-- Set indent for 2 for JavaScript files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.svelte" },
    command = "setlocal ts=2 sw=2"
})

-- Spellcheck
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }


lvim.colorscheme = "kanagawa-dragon"
-- require("everforest").setup({
--     background = "hard"
-- })

lvim.builtin.alpha.dashboard.section.header.val = {
    " ██░ ██  ▄▄▄     ▓██   ██▓ ▄▄▄     ▄▄▄█████▓    ▄▄▄▄    ██▓▄▄▄█████▓▄▄▄█████▓ ██▓",
    "▓██░ ██▒▒████▄    ▒██  ██▒▒████▄   ▓  ██▒ ▓▒   ▓█████▄ ▓██▒▓  ██▒ ▓▒▓  ██▒ ▓▒▓██▒",
    "▒██▀▀██░▒██  ▀█▄   ▒██ ██░▒██  ▀█▄ ▒ ▓██░ ▒░   ▒██▒ ▄██▒██▒▒ ▓██░ ▒░▒ ▓██░ ▒░▒██▒",
    "░▓█ ░██ ░██▄▄▄▄██  ░ ▐██▓░░██▄▄▄▄██░ ▓██▓ ░    ▒██░█▀  ░██░░ ▓██▓ ░ ░ ▓██▓ ░ ░██░",
    "░▓█▒░██▓ ▓█   ▓██▒ ░ ██▒▓░ ▓█   ▓██▒ ▒██▒ ░    ░▓█  ▀█▓░██░  ▒██▒ ░   ▒██▒ ░ ░██░",
    " ▒ ░░▒░▒ ▒▒   ▓▒█░  ██▒▒▒  ▒▒   ▓▒█░ ▒ ░░      ░▒▓███▀▒░▓    ▒ ░░     ▒ ░░   ░▓  ",
    " ▒ ░▒░ ░  ▒   ▒▒ ░▓██ ░▒░   ▒   ▒▒ ░   ░       ▒░▒   ░  ▒ ░    ░        ░     ▒ ░",
    " ░  ░░ ░  ░   ▒   ▒ ▒ ░░    ░   ▒    ░          ░    ░  ▒ ░  ░        ░       ▒ ░",
    " ░  ░  ░      ░  ░░ ░           ░  ░            ░       ░                     ░  ",
    "                  ░ ░                                ░                           ",
}

lvim.builtin.alpha.dashboard.section.footer.val = {
    "Don't worry"
}

lvim.builtin.alpha.dashboard.section.buttons.entries.insert = {
    "Shift + x",
    "󰮢  rm -rf /",
}

local lspconfig = require("lspconfig")


formatters.setup {
    { command = "templ", filetypes = { "templ" } }
}
