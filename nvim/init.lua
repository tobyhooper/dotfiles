-- vim-plug
vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
  Plug 'ThePrimeagen/harpoon'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'mfussenegger/nvim-lint'
  Plug 'mhartington/formatter.nvim'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

  call plug#end()
]]

--keymaps
vim.g.mapleader = " "

--netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })

-- theme
function Colour(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Colour()

--treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>py", mark.add_file)
vim.keymap.set("n", "<leader>ph", ui.toggle_quick_menu)

--mason
require("mason").setup()

--coq
-- Import COQ and enable it
vim.g.coq_settings = { auto_start = 'shut-up' } -- Auto-start COQ without manual intervention
local coq = require("coq")

-- Set up LSP with COQ
local lspconfig = require'lspconfig'
