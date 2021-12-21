"     ____    
"    / __ \   __
"   / / / /__/ / Danny Dasilva
"  / /_/ / _  /  dannydasilva.solutions@gmail.com
" /____,'\_,_/   https://github.com/Danny-Dasilva
" 
" A customized init.vim for neovim (https://neovim.io/)
"
" TABLE OF CONTENTS:
" 1. GENERIC SETTINGS
" 2. VIM-PLUG PLUGINS
" 3. USER INTERFACE AND NAVIGATION
" 4. COLORS AND STATUS LINE
" 5. TERMINAL
" 6. PLUGIN NAVIGATION
" 7. EDITING


" ==============================================================================
" 1. GENERIC SETTINGS
" ==============================================================================

"enable buffers (tabbed windows)
set hidden

"show line numbers 
set number 

"enable true color support (color themes will overlap otherwise)
set termguicolors
set t_Co=256
set encoding=UTF-8

" save all files on focus lost, ignoring warnings about untitled buffers
autocmd FocusLost * silent! wa

"save current file when buffer is or new file is opened 
set autowriteall

" ==============================================================================
" 2. VIM-PLUG PLUGINS
" ==============================================================================

" auto-install vim-plug (not entirely sure if functional)
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif



" Plug-ins
call plug#begin('~/.config/nvim/autoload/plugged')
 
    " Navigation
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                       " File search
    Plug 'junegunn/fzf.vim'  
    "Theme
    "Plug 'christianchiarulli/nvcode-color-schemes.vim'
    "Plug 'tomasiser/vim-code-dark'
    Plug 'wojciechkepka/vim-github-dark'
    Plug 'itchyny/lightline.vim'                                              " Lightline statusbar
    Plug 'mengelbrecht/lightline-bufferline'


    "Language support

    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'vim-python/python-syntax'                                           " added python syntax
    "Plug 'fatih/vim-go'
    "Ide plugins
    Plug 'neoclide/coc.nvim',{'branch': 'release'}                            " Vs code like intellisense
    Plug 'preservim/nerdtree'
    "Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    
    Plug 'ryanoasis/vim-devicons'                                             " Icons 
    Plug 'scrooloose/nerdcommenter'                                           " auto comment 
call plug#end()


" ==============================================================================
" 3. USER INTERFACE AND NAVIGATION
"
" ==============================================================================


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Don't wrap long lines
set nowrap

"removes the pipes on window split
set fillchars+=vert:\▏ 

"make new splits behave normally 
set splitbelow splitright

" Remap splits navigation to just SHIFT+ hjkl
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

"Remap swap window to CTRL + hjkl
nnoremap <C-h> <C-w>H
nnoremap <C-j> <C-w>J
nnoremap <C-k> <C-w>K
nnoremap <C-l> <C-w>L

"Adjust split sizes with CTRL + arrow keys
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" change two split windows from vert to horizontal or vice versa
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

"tab to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


" ==============================================================================
" 4. COLORS AND STATUS LINE
" ==============================================================================
let g:lightline = {
      \ 'colorscheme': 'ghdark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

hi Comment cterm=italic
"let g:codedark_hide_endofbuffer=1
"let g:codedark_terminal_italics=1
"let g:codedark_termcolors=256
syntax on
colorscheme ghdark 

set encoding=UTF-8


" Always show statusline
set laststatus=2

"keep filename on top
set showtabline=2

" ==============================================================================
" 5. TERMINAL
" ==============================================================================
"codedarkopen a terminal leader tt
map <Leader>tt :vnew term://bash<CR>
"escape exits terminal 
tnoremap <Esc> <C-\><C-n>

" ==============================================================================
" 6. PLUGIN NAVIGATION
" ==============================================================================

"Chadtree/nerdtree toggle
nmap <C-b> :CocCommand explorer <CR>

"szf fuzzy finder 
"search files in current dir
nmap <C-e> :Files<CR>
"ripgrep bound to leader g
nnoremap <leader>g :Rg<CR>
" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '.md'
"
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("Rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
"search current files
nnoremap<C-f> :BLines<CR>

"Comment text lines
map <C-_>   <Plug>NERDCommenterToggle
map <A-c>   <Plug>NERDCommenterToggle

" coc languageextensions
let g:coc_global_extensions = [
  \'coc-snippets',
  \'coc-explorer',
  \'coc-pairs',
  \'coc-python',
  \'coc-go',
  \'coc-json',
  \'coc-tsserver',
  \'coc-eslint',
  \'coc-css',
  \'coc-html',
  \'coc-prettier',
  \'coc-highlight',
  \'coc-emmet'
  \ ]
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent>  <C-k> :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"added references
nmap <leader>u <Plug>(coc-references)


"make sure enter does not spawn a new line if autofill tab is on screen
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"enable highlight list swapping
let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --no-quit --normal location


"use alt n(ext) and b(ack) for navigating through coc highlights
nnoremap <silent><nowait> <A-n> :CocCommand document.jumpToNextSymbol<CR>
nnoremap <silent><nowait> <A-b> :CocCommand document.jumpToPrevSymbol<CR>

"use tab and shift tab to select coc autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300


" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ==============================================================================
" 7. EDITING
" ==============================================================================
"python syntax highlight
let g:python_highlight_all = 1

"This unsets the "last search pattern" register by hitting enter
nnoremap <CR> :noh<CR><CR>

" esc in insert mode 
inoremap kj <Esc>
" esc in visual mode
"vnoremap kj <Esc>
" esc in command mode
cnoremap kj <C-C>

"quick snippets and formatting
nnoremap <silent> <A-a> :CocAction('doHover')<CR>
vnoremap <silent> <A-a> :CocAction('doHover')<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"use system keyboard
set clipboard+=unnamedplus

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"Leader R to reset vim 
noremap <Leader>r :so $MYVIMRC<CR>

"skip one character forward
inoremap <S-Tab> <esc>la
"go to end of line 
inoremap <A-l> <C-o>A
"CTRL A for select all
nnoremap <C-A> ggVG

"display keypress
set showcmd

"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
""dont fold methods of classes
""set foldnestmax=2
"au BufNewFile,BufRead *.py
    "\ set foldmethod=indent
"nnoremap <space> za


autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

"fu PyRun() range
  "echo system('python -c ' . shellescape(join(getline(a:firstline, a:lastline), "\n")))
"endf
"vmap <C-F6> :call PyRun()<CR>

" ==============================================================================
" 8. Programming Language Specific 
" ==============================================================================

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
let g:go_fmt_command = "goimports"
let g:go_gocode_propose_source = 0
let g:go_auto_type_info = 1
let g:go_version_warning = 0

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
