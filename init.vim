" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'dart-lang/dart-vim-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'rakr/vim-two-firewatch'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'kshenoy/vim-signature'
" Plugins for writing prose
Plug 'ron89/thesaurus_query.vim'
Plug 'reedes/vim-wordy'
Plug 'masukomi/vim-markdown-folding'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'wincent/command-t', {
\   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
\ }
Plug 'reedes/vim-pencil'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
filetype plugin on

" saves file before switching buffer
:au FocusLost * silent! wa

" autosaves file on cursor hold
autocmd CursorHold,CursorHoldI * update

" toggle status bar
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

" Color scheme
colo seoul256
" colorscheme two-firewatch
" let g:lightline={'colorscheme': 'twofirewatch'}
highlight Pmenu ctermbg=gray guibg=gray

" Toggle limelight plugin with Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set indent based on file type
autocmd FileType dart set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" set nohlsearch
set nohlsearch
" Indents word-wrapped lines as much as the 'parent' line
set breakindent
" Ensures word-wrap does not split words
set formatoptions=l
set lbr

" Key Mappings
" NOTE - use :map to debug keymappings. https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping
:let mapleader = ","

" List buffers and jump to given number
set autowrite
:nnoremap <leader>b :buffers<CR>:buffer<Space>
" Switch buffers 
nnoremap <leader><leader> :bn<CR>
" Tab and enter autocomplete behaviour (like in VSCode)
" Toggle with :CocEnable/Disable
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent> <ENTER> <CR>
" Toggle nerd tree
nnoremap <leader>t :NERDTreeToggle <CR>
" Toggle CommandT (fuzzy search)
nnoremap <leader>f :CommandT <CR>
" Navigate between windows
nnoremap <leader><TAB> <c-w><c-w>
nnoremap <leader><Right> <c-w><Right>
nnoremap <leader><Left> <c-w><Left>
nnoremap <leader><Up> <c-w><Up>
nnoremap <leader><Down> <c-w><Down>
" Close current window
nnoremap <leader>q <c-w>q
" Remap keys for goto definition
nmap <silent> gd <Plug>(coc-definition)
" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
nmap <leader>a <Plug>(coc-codeaction)
" Open init.vim
nnoremap <leader><CR> :e ~/.config/nvim/init.vim <bar> :source ~/.config/nvim/init.vim <CR>

" PROSE
" timer for autocommit
" thesaurus (g:tq_openoffice_en_file = /Users/Shared/myspell/openoffice_en_thesaurus/th_en_US_new)
let g:tq_openoffice_en_file = "/Users/Shared/myspell/openoffice_en_thesaurus/th_en_US_new"
nnoremap <leader>T :ThesaurusQueryReplaceCurrentWord <CR>
" marks
nnoremap gm ]'
nnoremap gM ['
" single folding
nnoremap <SPACE> za
" toggle fold for all
let $unrol=0
function UnrolMe()
if $unrol==0
    :exe "normal zR"
    let $unrol=1
else
    :exe "normal zM"
    let $unrol=0
endif
endfunction
nnoremap <leader><SPACE> :call UnrolMe() <CR>
" jump to end fold
nnoremap ] :/# <CR> k
" word count
nnoremap <leader>w g<c-g>
" wordy
nnoremap <leader>S :<C-u>NextWordy<cr>
let g:wordy#ring = ['weak', 'redundant', 'problematic', 'puffery', 'being', 'passive-voice', 'adjectives', 'adverbs']
" expected navigation behaviour when line wraps
map j gj
map k gk
" Toggle spellcheck
:map <leader>sp :set spell! spelllang=en_gb<CR>
:map <leader>s z=
" Goyo
let g:goyo_width = "75%"
let g:goyo_height = "95%"
nnoremap <leader>p :Goyo <CR> :PencilToggle <CR>
" TIPS
" use ctrl-z to suspend vim and go back to the terminal, fg to resume
" run so % to load init.vim

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Misc "
set number
