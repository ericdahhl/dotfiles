" Eric vimrc/init.vim
let mapleader=" "
set guicursor=
set number
set hidden
set noswapfile
set nowrap
set smartindent
set noswapfile
set nobackup
" set undodir=~/.vim/undodir
" set undofile
set incsearch
set scrolloff=8
set noshowmode
set colorcolumn=80
set updatetime=50
set mouse=a
set visualbell
set updatetime=300

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set completeopt=menuone,noselect

autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

" Tab complete
set wildmode=longest,list,full
set wildmenu

" Display trailing whitespace
set list listchars=tab:»·,trail:·,nbsp:·

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

augroup WrapLineForSpecificFiles
    autocmd!
    au BufRead,BufNewFile *.md setlocal textwidth=80
    autocmd FileType markdown setlocal wrap
augroup END

" Tree stuff
nnoremap <C-n> :NvimTreeToggle<CR>
" Fzf stuff
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>fl :Lines<CR>

autocmd FileType python nnoremap <leader>rp :!python3 %:r.py<CR>

" Competetive programming
autocmd FileType python nnoremap  <leader>rt :!for f in %:r.*.test; do echo "TEST: $f"; python3 %:r.py < $f; done<CR>
autocmd FileType cpp nnoremap     <leader>rb    :!g++ -g --std=c++17 % -o %:r<CR>
autocmd FileType cpp nnoremap     <leader>rr    :!./%:r<CR>
autocmd FileType cpp nnoremap     <leader>rt    :!for f in %:r.*.test; do echo "TEST: $f"; ./%:r < $f; done<CR>
" WSL specific for piping a whole file to clipboard (used to submit code)
nnoremap <leader>cp :!cat % <bar> clip.exe<CR>


call plug#begin('~/.vim/plugged') 

" Visual stuff
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'

" Extend editor functionality
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'

Plug 'b3nj5m1n/kommentary'
Plug 'honza/vim-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

set termguicolors
colorscheme gruvbox-material

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "erlang", "nix", "devicetree", "ocamllex", "supercollider", "gdscript", "ledger" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "erlang", "nix", "devicetree", "ocamllex", "supercollider", "gdscript", "ledger" }
  },
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg='#3c3836'
      hi LspReferenceText cterm=bold ctermbg=red guibg='#3c3836'
      hi LspReferenceWrite cterm=bold ctermbg=red guibg='#3c3836'
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

require'lspsaga'.init_lsp_saga()

vim.api.nvim_set_keymap("n", "<C-G>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-G>", "<Plug>kommentary_visual_default", {})
EOF

" nvim-compe mappings
inoremap <silent><expr> <c-space> compe#complete()
inoremap <silent><expr> <cr>      compe#confirm('<cr>')
inoremap <silent><expr> <c-e>     compe#close('<c-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

