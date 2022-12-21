local g = vim.g

g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = false
      }
    },
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  renderer = {
    icons = {
      padding = ' ',
      symlink_arrow = ' >> ',
      show = {
        git = true,
        folder = true,
        file = true,
      }, 
    },
    highlight_opened_files = 'icon',
    root_folder_modifier = ':~',
    group_empty = true,
    add_trailing = true,
    highlight_git = true,
    indent_markers = {
      enable = true
    }
  }
}