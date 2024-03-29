local g = vim.g

g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

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
    hide_root_folder = false,
	float = {
	  enable = true,
	  open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
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
