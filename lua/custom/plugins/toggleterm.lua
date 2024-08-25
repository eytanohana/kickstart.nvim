local map = vim.keymap.set
local toggle_term_group = vim.api.nvim_create_augroup('toggle_term', { clear = true })

local function toggle_or_focus_toggleterm()
  -- Save the current buffer and exit insert mode if necessary
  if vim.fn.mode() == 'i' then
    vim.cmd 'stopinsert'
  end

  -- Find if there is an open ToggleTerm window
  local term_winid = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'toggleterm' then
      term_winid = win
      break
    end
  end

  if term_winid then
    if vim.api.nvim_get_current_win() == term_winid then
      -- If ToggleTerm is already focused, close it
      vim.cmd 'ToggleTerm'
    else
      -- If ToggleTerm is open but not focused, focus it
      vim.api.nvim_set_current_win(term_winid)
    end
  else
    -- If ToggleTerm is not open, open it in a split at the bottom
    vim.cmd 'ToggleTerm direction=horizontal'
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = toggle_term_group,
  pattern = 'toggleterm',
  callback = function()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<A-3>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-l>', [[<C-\><C-n><C-W>l]], opts)
  end,
})

map({ 'n', 'i' }, '<A-3>', toggle_or_focus_toggleterm)

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'horizontal', -- Default split direction
      size = 10, -- Size of the horizontal split
    }
  end,
}
