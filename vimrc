" vimrc - Justin de Vesine (justin@devesine.com) {{{
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
" }}}

" Pathogen {{{
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                    " force reloading *after* pathogen loaded
call pathogen#infect()
filetype plugin indent on       " enable detection, plugins and indenting in one step
" }}}

" Notes {{{
" ramdisk creation
" diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://195312`

" call pathogen#helptags() " Regenerate helpfiles for bundles.
" Takes a long time, shouldn't be run at startup.
" Instead, run this when updating: vim -c 'call pathogen#helptags()|q'
" }}}

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set noexpandtab                 " do not expand tabs by default per crowdfavorite preferences (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=block             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set fillchars=vert:\ 
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·,eol:¬

set list                        " show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)
set formatoptions-=t

set synmaxcol=600				" don't try to syntax highlight very long lines
set textwidth=0
set wrapmargin=4

" }}}

" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with nothing folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold

set foldtext=MyFoldText()
" }}}
	
" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo

if v:version >= '702' && has('persistent_undo')
	set undofile                " keep a persistent backup file
	set undodir=~/.vim/.undo,~/tmp,/tmp
endif

set nobackup                    " do not keep backup files, it's 70's style cluttering
set swapfile					" swapfiles are critical working with large files
set updatecount=0				" but not for general editing

set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=longest:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.pyo
set wildignore+=*.class
set wildignore+=*.t3o,*.t3s
set wildignore+=*.o,*.obj,*~
set wildignore+=*.png,*.jpg,*.gif

set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set modeline                  " enable mode lines (disabling is a security measure)
"set ttyfast                     " always use a fast terminal
set cursorline                  " underline the current line, for quick orientation


command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

"command CurrentGroup :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

command CurrentGroup :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

" don't automatically fold php files"
"let g:DisableAutoPHPFolding = 1

" }}}

" Extra vi-compatibility {{{
" set extra vi-compatible options
set cpoptions+=$     " when changing a line, don't redisplay, but put a '$' at
                     " the end during the change
set formatoptions-=o " don't start new lines w/ comment leader on pressing 'o'
if has("autocmd")
	au filetype vim set formatoptions-=o
                     " somehow, during vim filetype detection, this gets set
                     " for vim files, so explicitly unset it again
endif
" }}}

" Enabling syntax highlighting {{{
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Highlight conflict markers {{{
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" function: numbertoggle {{{

if v:version >= '703'
	function! LineNumberToggle()
		if(&relativenumber == 1)
			set nonumber
			set norelativenumber
		elseif (&number == 1)
			set relativenumber
		else
			set number
		endif
	endfunc
else
	function! LineNumberToggle()
		if (&number == 1)
			set nonumber
		else
			set number
		endif
	endfunc
endif

" }}}

" function: MyFoldText and variants {{{
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction

" Inform folding function {{{
function! MyInformFoldText()
    let line = getline(v:foldstart + 1)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
" }}}
" }}}

" GUI options and color scheme {{{
if has("gui_running") "
    "set guifont=Inconsolata:h14
	set guifont=Inconsolata\ For\ Powerline:h14,Consolas:h12
    "colorscheme baycomb
    "colorscheme mustang
    "colorscheme molokai
    set bg=dark
    let g:solarized_termcolors=256
    let g:solarized_bold = 1
    let g:solarized_underline = 1
    let g:solarized_italic = 1
    colorscheme solarized

    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

	set guicursor+=a:blinkon0

else
    set bg=dark
    let g:solarized_termcolors=256
    colorscheme solarized
endif " }}}

" Abbreviations: Lorem Ipsum {{{
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor
" }}}

" Plugin settings {{{
" NERDTree settings {{{
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=0

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', 
			\ '\~$']

let NERDTreeShowLineNumbers=1

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

" Auto open nerd tree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
" Focus in the main content window
let g:nerdtree_tabs_focus_on_files = 1

" }}}

" TagList settings {{{
" quit Vim when the TagList window is the last open window
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files,
" but we have already turned off swap files (earlier)
"set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}

" ZenCoding settings {{{

let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

" }}}

" SuperTab settings {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabCrMapping = 0
" }}}
 
" ShowFunc settings {{{
let g:ShowFuncScanType = "current"
" }}}

" delimitMate settings {{{
let loaded_delimitMate = 1
let g:delimitMate_expand_cr = 1
" }}}

" YankRing settings {{{
let g:yankring_max_element_length = 65536
let g:yankring_history_dir = '$HOME/.vim/.tmp'
" }}}

" Gundo settings {{{
" open on the right so as not to compete with the nerdtree
let g:gundo_right = 1 
" }}}

" Syntastic settings {{{
let g:syntastic_enable_signs=1
let g:syntastic_echo_current_error=1
let g:syntastic_mode_map = { 'mode': 'passive',
							\ 'active_filetypes' : [],
							\ 'passive_filetypes': [] }

" }}}

" tagbar settings {{{
if filereadable('/usr/local/Cellar/ctags/5.8/bin/ctags')
	let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8/bin/ctags'
endif
if filereadable('/usr/local/bin/jsctags')
	let g:tagbar_type_javascript = {
				\ 'ctagsbin' : '/usr/local/bin/jsctags'
				\ }
endif
let g:tagbar_compact = 1

" }}}
" }}}

" Status line customization {{{
set statusline=%#DiffAdd#
set statusline+=%f
set statusline+=\ 
set statusline+=%#LineNr#
set statusline+=%m
set statusline+=%#DiffAdd#
set statusline+=%r
set statusline+=%#LineNr#
set statusline+=%{fugitive#statusline()}
set statusline+=%y
set statusline+=%#DiffChange#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#DiffAdd#
set statusline+=\ %=
set statusline+=%#LineNr#
set statusline+=%-14.(%l,%c%V%)\ %P\ 
set statusline+=%*
" }}}

" local includes {{{
source ~/.vim/inc/autocmd.vim
source ~/.vim/inc/mapping.vim
" }}}

" Extra user or machine specific settings {{{
source ~/.vim/user.vim
" }}}

