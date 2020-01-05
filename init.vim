" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'dart-lang/dart-vim-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'rakr/vim-two-firewatch'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
filetype plugin on

" Colorscheme
colorscheme two-firewatch
let g:lightline={'colorscheme': 'twofirewatch'}
highlight Pmenu ctermbg=gray guibg=gray

" Set indent based on file type
autocmd FileType dart set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

:let mapleader = ","

:mapclear
" NOTE - use :map to debug keymappings. https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping
"
" Tab and enter autocomplete behaviour (like in VSCode)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent> <ENTER> <CR>
" Toggle nerd tree
nnoremap <leader>t :NERDTreeToggle <CR>
" Navigate between windows
nnoremap <TAB> <c-w><c-w>
" Remap keys for goto definition
nmap <silent> gd <Plug>(coc-definition)
" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
nmap <leader>a <Plug>(coc-codeaction)
" Open init.vim
nnoremap <leader><leader> :e ~/.config/nvim/init.vim <CR>

" run so % to load init.vim

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Other config"
set number

