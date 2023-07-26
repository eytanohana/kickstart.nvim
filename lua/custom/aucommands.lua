local api = vim.api
local clear = { clear = true }

-- create general au group
local general = api.nvim_create_augroup('General', clear)


-- go to the last location the cursor was at when opening a file
api.nvim_create_autocmd('BufReadPost',
    {
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
        group = general
    }
)


-- check for external edits to the file
api.nvim_create_autocmd({'FocusGained', 'BufEnter'},
    {
        command = 'checktime',
        group = general
    }
)


-- Highlight on yank 
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end,
  group = general,
  pattern = '*',
})


local qflist = api.nvim_create_augroup('QuickFixList', clear)

api.nvim_create_autocmd(
    'FileType',
    {
        group = qflist,
        pattern = 'qf',
        callback = function()
            api.nvim_buf_set_keymap(0, 'n', 'J', 'j<CR>zz<C-w>j', { noremap = true, silent = true })
            api.nvim_buf_set_keymap(0, 'n', 'K', 'k<CR>zz<C-w>j', { noremap = true, silent = true })
            api.nvim_buf_set_keymap(0, 'n', 'q', 'ZQ', { noremap = true, silent = true })
        end
    }
)

local python_group = api.nvim_create_augroup('PythonGroup', clear)
api.nvim_create_autocmd(
    'FileType',
    {
        group = python_group,
        pattern = 'python',
        callback = function()
            vim.cmd[[ CC ]]
        end
    }
)
