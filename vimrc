" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"set nocp
filetype plugin on

map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
map <F3> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F6> :ToggleSpaceHi<CR>

:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

autocmd VimEnter * nmap <F5> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F5> <Esc>:NERDTreeToggle<CR>a
let NERDTreeWinSize=35

" omnicppcomplete is not used prior to clang_complete
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 0
"let OmniCpp_ShowPrototypeInAbbr = 1

let g:spacehi_tabcolor="ctermfg=White ctermbg=Darkgrey guifg=White guibg=Red"
let g:spacehi_spacecolor="ctermfg=White ctermbg=Red guifg=Blue guibg=Yellow"
let g:spacehi_nbspcolor="ctermfg=White ctermbg=Red guifg=White guibg=Red"

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set autoindent
set cindent
set cinoptions+=g0

nmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Cpp11 syntax highlighting
au BufNewFile,BufRead *.cpp set syntax=cpp11
au BufNewFile,BufRead *.cc set syntax=cpp11

set t_Co=256
color jellybeans

let g:clang_use_library=1
let g:clang_complete_auto=0
set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!

let g:EchoFuncKeyPrev='<Leader>['
let g:EchoFuncKeyNext='<Leader>]'

function! CloseHiddenBuffers()
" figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
" close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      exe 'bd ' . b
    endif
  endfor
endfun
map <F7> :buffers<CR>
map <F8> :call CloseHiddenBuffers()<CR>
