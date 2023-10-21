local home = vim.fn.expand('~')


local opts = {
	fileencoding="utf-8",
	pumheight = 10, --maximum items in popup
	showmode = false,
	ignorecase = true,
	smartcase = true,


	termguicolors = true,
	guicursor = "",

	syntax = 'on',

	keymap='russian-jcukenwin',
	iminsert=0,
	imsearch=0,

	clipboard = "unnamedplus",

	-- setlocal spell spelllang=ru_yo,en_us

	tags = vim.opt.tags + (home .. "/.config/nvim/tags"),
	tags = vim.opt.tags + (home .. "/.local/nvim/nvim-linux64/share/nvim/runtime/doc/tags"),

	-- Ignore compiled files
	wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" },

	-- Cool floating window popup menu for completion on command line
	pumblend = 17,
	wildmode = "longest:full",
	wildoptions = "pum",

	-- Tabs
	tabstop=4,
	softtabstop=4,
	shiftwidth=4,
	expandtab = true,
	smartindent = true,

	number = true,
	relativenumber = true,
	wrap = true,              -- do not wrap line of text
	hlsearch = false,
	hidden = true,              -- do not unload buffers, keep it in background
	errorbells = false,
	swapfile = false,
	backup = false,
	undodir=(home .. '/.config/nvim/vim_undodir'),
	undofile = true,
	incsearch = true,
	scrolloff=8,
	colorcolumn='120',
	signcolumn = 'yes',

	-- vim.opt.listchars = {
	--     eol='↵',
	--     trail='~',
	--     tab='>-',
	--     nbsp='␣'
	-- }
	-- vim.opt.list = true

	cmdheight=1,
	updatetime=50,       -- default is 4000ms = 4s

	mouse='a',

	splitbelow = true,
	splitright = true,

	formatoptions = vim.opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore
}

local  globals = {
	mapleader =  " ",
	maplocalleader =  " ",
	-- FILE BROWSER:
	netrw_banner = 0,              -- disable banner
	netrw_preview = 1,             -- vertical split for preview
	--netrw_altv = 1,                -- open splits to the right
	netrw_liststyle = 3,           -- tree view
	netrw_winsize = 30,            -- use only 30% of screen for netrw
	netrw_browse_split = 4,        -- open in prev window
	--netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]], -- use .gitignore
	-- check |netrw-browse-maps| for mappings

	-- disable unused providers
	loaded_ruby_provider = 0,
	loaded_perl_provider = 0,
	loaded_python_provider = 0,
	python3_host_prog = (home .. '/.local/pyenv/versions/neovim3/bin/python')
}

vim.fn.matchadd('errorMsg', [[\s\+$]]) -- Highlight trailing whitespaces
for k, v in pairs(opts) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
