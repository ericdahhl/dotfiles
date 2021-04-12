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

" Coc stuff
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)

" Tree stuff
nnoremap <C-n> :NvimTreeToggle<CR>
" Fzf stuff
nnoremap <leader>fi :Files<CR>
nnoremap <leader>fb :Buffers<CR>
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
" Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'

" Extend editor functionality
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "erlang", "nix", "devicetree", "ocamllex", "supercollider", "gdscript", "ledger" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "erlang", "nix", "devicetree", "ocamllex", "supercollider", "gdscript", "ledger" }
  },
}
EOF

colorscheme gruvbox-material
set termguicolors
