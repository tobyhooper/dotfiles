--nvtoby
--The greatest neovim config ever made

-- vim-plug
vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'no-clown-fiesta/no-clown-fiesta.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'williamboman/mason.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
  Plug 'github/copilot.vim'

  call plug#end()
]]

-- General setup
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 4

-- Netrw
vim.keymap.set("n", "<leader>pf", vim.cmd.Ex)

--terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>i', { noremap = true, silent = true })

-- Theme
function Colour(color)
	color = color or "no-clown-fiesta"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>py", mark.add_file)
vim.keymap.set("n", "<leader>ph", ui.toggle_quick_menu)

-- Mason
require("mason").setup()

-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})

-- lsp-zero setup
local lsp_zero = require('lsp-zero')

local servers = {
  'pyright',  -- Example for Python
  -- Add other servers as needed
}

local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  -- Add other key mappings as needed
end

for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    on_attach = lsp_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
end

-- Finalize lsp-zero setup
lsp_zero.setup()

-- Neovide settings
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10
vim.g.neovide_transparency = 0.90
--vim.cmd('highlight Normal guibg=#181818')
vim.opt.guifont = "MesloLGS NF:h11"

-- Ctrl+Shift+V paste
vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-v>', '"+p', { noremap = true, silent = true })

-- Set colorscheme
Colour()
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#1e1e1e', fg = '#ffffff' })
