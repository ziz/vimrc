if exists('g:loaded_jdv_mapping')
	finish
endif
let g:loaded_jdv_mapping = 1

" Change the mapleader from \ to , {{{
let mapleader=","
"}}}

" always use Very magic mode for regex by default {{{
" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v
"}}}

" Tame the quickfix window (open/close using ,f) {{{
nnoremap <silent> <leader>f :QFix<CR>
"}}}

" Use Q for formatting the current paragraph (or visual selection) {{{
vnoremap Q gq
nnoremap Q gqap
"}}}

" make p in Visual mode replace the selected text with the yank register {{{
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
"}}}

" Shortcut to make {{{
nnoremap mk :make<CR>
"}}}

" Swap implementations of ` and ' jump to markers {{{
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
"nnoremap ' `
"nnoremap ` '
"}}}

" Remap j and k to act as expected when used on long, wrapped, lines {{{
"nnoremap j gj
"nnoremap k gk
"}}}

" Easy window splitting {{{
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
"}}}

" Complete whole filenames/lines with a quicker shortcut key in insert mode {{{
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>
"}}}

" Yank/paste to the OS clipboard with ,y and ,p {{{
"nmap <leader>y "+y
"nmap <leader>Y "+yy
"nmap <leader>p "+p
"nmap <leader>P "+P
"}}}

" YankRing stuff {{{
nnoremap <leader>r :YRShow<CR>
"}}}

" Edit the vimrc file {{{
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
"}}}

" Clears the search register {{{
nnoremap <silent> <leader>/ :nohlsearch<CR>
"}}}

" Pull word under cursor into LHS of a substitute  {{{
nnoremap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#
"}}}

" Quick alignment of text {{{
"nnoremap <leader>al :left<CR>
"nnoremap <leader>ar :right<CR>
"nnoremap <leader>ac :center<CR>
"}}}

" Sudo to write {{{
cmap w!! w !sudo tee % >/dev/null
"}}}

" Jump to matching pairs easily, with Tab {{{
"nnoremap <Tab> %
"vnoremap <Tab> %
"}}}

" Folding {{{
nnoremap <Space> za
vnoremap <Space> za
"}}}

" Strip all trailing whitespace from a file, using ,w {{{
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" }}}

" Run Ack fast {{{
" nnoremap <leader>a :Ack<Space>
"}}}

" Creating folds for tags in HTML {{{
"nnoremap <leader>ft Vatzf
"}}}

" Reselect text that was just pasted with ,v {{{
nnoremap <leader>v V`]
"}}}

" Gundo.vim {{{
nnoremap <F5> :GundoToggle<CR>
nnoremap ,u :GundoToggle<CR>
"}}}

" nerdtree {{{
" Put focus to the NERD Tree with <leader> (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nnoremap <leader>n :NERDTreeClose<CR>:NERDTreeMirrorToggle<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>

" }}}

" shortcut to jump to next conflict marker {{{
nnoremap <silent> <leader>C /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Creating underline/overline headings for markup languages {{{
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"
" }}}

" handy keybindings {{{

" Edit and source vimrc
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Use numbers to pick the tab you want (like iTerm)
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

" Get the current highlight group. Useful for then remapping the color
map ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

map ,cd :lcd %:p:h<CR>
map ,cD :cd %:p:h<CR>

" }}}

" Gitv {{{
nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>
vnoremap <leader>gV :Gitv! --all<cr>
" }}}

" line number {{{
nnoremap <silent> <C-l> :call LineNumberToggle()<cr>
" }}}

" tagbar {{{
nnoremap <F8> :TagbarToggle<CR>
"}}}

" Command mode bindings {{{
cnoremap <c-a> <home>
cnoremap <c-e> <end>
"}}}

