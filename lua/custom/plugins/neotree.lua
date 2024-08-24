return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      add_blank_line_at_top = true, -- Add a blank line at the top of the tree.
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        filtered_items = {
          visible = true,
        },
        window = {
          mappings = {
            ['l'] = 'open',
            ['h'] = 'close_node',
          },
        },
      },
    }

    vim.keymap.set('n', '<A-0>', ':Neotree toggle reveal_force_cwd<CR>', { silent = true })

    -- Create an augroup for NeoTree autocommands
    local neo_tree_tab_sync_group = vim.api.nvim_create_augroup('NeoTreeTabSync', { clear = true })
    local function is_neotree_open()
      -- Check if NeoTree is not already open in the current tab
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
        if bufname:match 'NeoTree' then
          return true
        end
      end
      return false
    end

    -- Auto-open NeoTree when switching tabs
    vim.api.nvim_create_autocmd('TabEnter', {
      group = neo_tree_tab_sync_group, -- Add to the created augroup
      callback = function()
        local win_found = is_neotree_open()
        if not win_found then
          vim.cmd 'Neotree show'
        end
      end,
    })

    vim.api.nvim_create_autocmd('TabLeave', {
      group = neo_tree_tab_sync_group, -- Add to the created augroup
      callback = function()
        vim.cmd 'Neotree close'
      end,
    })
  end,
}
