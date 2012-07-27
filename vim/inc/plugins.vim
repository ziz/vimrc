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

