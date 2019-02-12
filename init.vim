if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'ryanoasis/vim-devicons'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'moll/vim-bbye'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

"===============
" Configurations
"===============

" set up tab space and convert tabs into spaces
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set foldlevel=2

" show line numbers
set number
set cursorline
set lazyredraw
set nowrap
set background=dark
set termguicolors

syntax on
colorscheme lucius

" highlight matching braces
set showmatch
set cursorline
set noswapfile

" search config
set incsearch
set hlsearch

" Navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"=====================
"Plugin Configurations
"=====================

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"NERDTree Configuration

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"

" Autolaunch NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Focus main window, not NERDTree
augroup NERD
  autocmd!
  autocmd VimEnter * NERDTree
  autocmd VimEnter * wincmd p
augroup END

augroup filetypedetect
  au BufRead,BufNewFile Jenkinsfile set filetype=groovy
augroup END

" Exit Vim when the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
 function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
   exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Airline configuration
    set laststatus=2
    " To show the buffers open on the top status bar
    let g:airline#extensions#tabline#enabled = 1
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    if !exists('g:airline_powerline_fonts')
      let g:airline#extensions#tabline#left_sep = ' '
      let g:airline#extensions#tabline#left_alt_sep = '|'
      let g:airline_left_sep          = ''
      let g:airline_left_alt_sep      = '»'
      let g:airline_right_sep         = ''
      let g:airline_right_alt_sep     = '«'
      let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
      let g:airline#extensions#readonly#symbol   = '⊘'
      let g:airline#extensions#linecolumn#prefix = '¶'
      let g:airline#extensions#paste#symbol      = 'ρ'
      let g:airline_symbols.linenr    = '␊'
      let g:airline_symbols.branch    = '⎇'
      let g:airline_symbols.paste     = 'ρ'
      let g:airline_symbols.paste     = 'Þ'
      let g:airline_symbols.paste     = '∥'
      let g:airline_symbols.whitespace = 'Ξ'
    else
      let g:airline#extensions#tabline#left_sep = ''
      let g:airline#extensions#tabline#left_alt_sep = ''
      " powerline symbols
      let g:airline_left_sep = ''
      let g:airline_left_alt_sep = ''
      let g:airline_right_sep = ''
      let g:airline_right_alt_sep = ''
      let g:airline_symbols.branch = ''
      let g:airline_symbols.readonly = ''
      let g:airline_symbols.linenr = ''
    endif

" Airline theme
let g:airline_theme='lucius'

" file finder mapping
let g:ctrlp_map = ',e'
" open buffers finder mapping
nmap ,b :CtrlPBuffer<CR>
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction

"Open the files always in a new buffer
let g:ctrlp_switch_buffer = 0
"Don't change working directory
let g:ctrlp_working_path_mode = 0

" Deople config
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'

" ale configuration
    let g:ale_linters = {
    \   'python': ['pylint', 'flake8'],
    \}
    let g:ale_lint_delay = 1000
    " set statusline+=%{ALEGetStatusLine()}
    let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
    let g:ale_python_pylint_change_directory = 0

