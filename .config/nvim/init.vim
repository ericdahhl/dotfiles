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
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType vue setlocal ts=2 sts=2 sw=2

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
    au BufRead,BufNewFile *.md,*.tex setlocal textwidth=80
    autocmd FileType markdown,tex setlocal wrap
augroup END

augroup MarkdownSpell
    autocmd!
    autocmd FileType markdown,tex setlocal spell
    autocmd BufRead,BufNewFile *.md,*.tex setlocal spell
augroup END

autocmd FileType python nnoremap <leader>rp :!python3 %:r.py<CR>

" Competetive programming
autocmd FileType python nnoremap  <leader>rt :!for f in %:r.*.test; do echo "TEST: $f"; python3 %:r.py < $f; done<CR>
autocmd FileType cpp nnoremap     <leader>rb    :!g++ -g --std=c++17 % -o %:r<CR>
autocmd FileType cpp nnoremap     <leader>rr    :!./%:r<CR>
autocmd FileType cpp nnoremap     <leader>rt    :!for f in %:r.*.test; do echo "TEST: $f"; ./%:r < $f; done<CR>
" WSL specific for piping a whole file to clipboard (used to submit code)
nnoremap <leader>cp :!cat % <bar> clip.exe<CR>
vnoremap <leader>cp :'<,'>:w !clip.exe<CR>

lua <<EOF
require('plugins')

require('gitsigns').setup()
require('material').setup({
    text_contrast = { lighter = true, darker = false }
})

vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
EOF

set termguicolors
let g:edge_style = 'neon'
colorscheme material

" Tree stuff
nnoremap <C-n> :NvimTreeToggle<CR>

" Telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>rg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>s <cmd>lua require('telescope.builtin').spell_suggest()<cr>

