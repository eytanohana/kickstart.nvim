local set = vim.o

-- set tabs to 4 spaces
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- show tabs
set.showtabline = 4

-- be smart when using tabs ;)
set.smarttab = true
set.smartindent = true

-- expand tabs into spaces
set.expandtab = true

-- auto indent
set.autoindent = true

-- highlight the current line
set.cursorline = true

-- show line numbers/relative line numbers
set.number = true
set.relativenumber = true

-- case insensitive search unless uppercase is included
set.ignorecase = true

-- disable swap file
set.swapfile = false

-- file formats/encodings
set.fileformat = 'unix'
set.encoding = 'utf-8'

-- Set to auto read when a file is changed from the outside
set.autoread = true

-- Sync clipboard between OS and Neovim.
set.clipboard = 'unnamedplus'

-- keep the cursor 2 lines from the top/bottom
set.scrolloff = 2

-- open new splits below and right
set.splitbelow = true
set.splitright = true

-- Enable folding
set.foldmethod = 'indent'
set.foldlevel = 99

-- dont autowrap long lines
set.wrap = false

-- Don't redraw while executing macros (good performance config)
set.lazyredraw = true

-- For regular expressions turn magic on
set.magic = true

-- visual block stays in its lane
set.startofline = false

-- better menu completion/selection
set.completeopt = 'menuone,noinsert,noselect'

-- set undotree file directory
set.undodir = os.getenv('HOME') .. '/.config/nvim/.undodir'
set.undofile = true

-- enable mouse
set.mouse = 'a'

-- highlight search
set.hlsearch = true

-- Decrease update time (ms)
set.updatetime = 250
set.timeoutlen = 300


-- set.signcolumn = 'yes'

-- more terminal colors
set.termguicolors = true

-- Enable break indent
vim.o.breakindent = true

