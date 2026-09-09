-- Go filetype settings.
-- Loaded automatically by Neovim for every Go buffer.

local opt = vim.opt_local

-- gofmt indents with tabs, so tabs must stay tabs here (the global default expands
-- them into spaces). Width 4 is what gofmt assumes when it aligns struct tags.
opt.expandtab = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Go has no line-length convention; 120 is a soft guide, not a hard wrap.
opt.colorcolumn = '120'
opt.textwidth = 0

-- Format options: auto-wrap comments, insert comment leader, allow gq on comments
opt.formatoptions = 'croqjnl'

-- Keep everything unfolded on load (global foldexpr is treesitter-based)
opt.foldlevel = 99

-- Copy a runnable `go test` command for the nearest test: the enclosing Test/Benchmark/
-- Fuzz/Example function, anchored so -run matches it exactly, scoped to its package dir.
-- Outside a test function it falls back to the whole package.
vim.api.nvim_buf_create_user_command(0, 'CopyGoTest', function()
  local dir = './' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.:h')

  -- Lua patterns have no alternation, so check the four `go test` prefixes in turn.
  local function is_test_func(fn_name)
    for _, prefix in ipairs { 'Test', 'Benchmark', 'Fuzz', 'Example' } do
      if vim.startswith(fn_name, prefix) then
        return true
      end
    end
    return false
  end

  -- Walk upward so a closure inside the test (t.Run, a table-driven subtest) still
  -- resolves to the enclosing top-level test function.
  local name
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == 'function_declaration' then
      local name_node = node:field('name')[1]
      local candidate = name_node and vim.treesitter.get_node_text(name_node, 0)
      if candidate and is_test_func(candidate) then
        name = candidate
      end
    end
    node = node:parent()
  end

  local cmd
  if name then
    cmd = string.format("go test -race -run '^%s$' %s", name, dir)
  else
    cmd = string.format('go test -race %s', dir)
  end

  vim.fn.setreg('+', cmd)
  vim.notify('Copied "' .. cmd .. '" to clipboard.')
end, { desc = 'Copy `go test` command for nearest test' })

vim.keymap.set('n', 'cpt', ':CopyGoTest<CR>', { buffer = 0, silent = true, desc = 'Copy go test command' })
