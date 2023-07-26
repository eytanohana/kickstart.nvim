local map = vim.keymap.set
local toggle_term_group = vim.api.nvim_create_augroup( "toggle_term", { clear = true })

vim.api.nvim_create_autocmd(
    'FileType',
    {
        group = toggle_term_group,
        pattern = 'toggleterm',
        callback = function()
            local opts = {noremap = true}
            vim.api.nvim_buf_set_keymap(0, 't', '<A-3>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<A-j>', [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<A-l>', [[<C-\><C-n><C-W>l]], opts)
        end
    }
)

map('n', '<A-3>', ':ToggleTerm<CR>')
map('i', '<A-3>', '<ESC>:ToggleTerm<CR>')


return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true,
}
