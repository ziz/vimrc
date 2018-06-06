if exists('g:loaded_jdv_autocmd')
	finish
endif
let g:loaded_jdv_autocmd = 1

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype php setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_help "{{{
    	au!

    	autocmd filetype help setlocal nonumber
    	if v:version >= '703'
			autocmd filetype help setlocal norelativenumber
		endif
    	autocmd filetype help setlocal foldcolumn=0
	"}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        "autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        autocmd BufNewFile,BufRead *.html,*.htm,*.tmpl set ft=html

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
		" autocmd filetype html let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml setlocal formatoptions-=tc
        autocmd filetype html,xhtml,xml setlocal wrap
        autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim
        " local syntax overrides for html in text/html script tags
        autocmd filetype html,php syn clear javaScript
		autocmd filetype html,php syn region  javaScript start=+<script\(>\|\([^>]\(type *=[^>]*html\)\@!\)*\)>+ keepend end=+</script>+me=s-1 contains=@htmlJavaScript,htmlCssStyleComment,htmlScriptTag,@htmlPreproc
		autocmd filetype html,php syn region  htmlScriptRegion start=+<script [^>]*type *=[^>]*html[^>]*>+ keepend end=+</script>+me=s-1 contains=@htmlTop
		autocmd filetype html,php syn sync match htmlHighlight groupthere javaScript "<script \([^>]\(type *=[^>]*html\)\@!\)*>"
		autocmd filetype html,php syn sync match htmlHighlight groupthere htmlScriptRegion "<script [^>]*type *=[^>]*html"

    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
		" autocmd filetype python setlocal textwidth=80
        " autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
		"autocmd BufWritePost *.py call Pyflakes()
    augroup end " }}}

    augroup ruby_files "{{{
        au!

		au BufNewFile,BufRead Capfile      setf ruby
        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

	augroup ls "{{{
		au!
		autocmd filetype ls setlocal foldmethod=indent nofoldenable noexpandtab
		autocmd filetype ls setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd filetype ls setlocal formatoptions-=t
		autocmd filetype ls vmap <buffer> <leader>C <esc>:'<,'>:LiveScriptCompile<CR>
		autocmd filetype ls map <buffer> <leader>C :LiveScriptCompile<CR>
		autocmd filetype ls command-buffer -nargs=1 C LiveScriptCompile | :<args>
	augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal noexpandtab
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup php_files "{{{
		au!
		
		au BufReadPre php let php_sql_query=1
		au BufReadPre php let php_htmlInStrings=1
		au BufReadPre php let php_folding=1
		au BufReadPre php let php_noShortTags =1

		autocmd FileType php setlocal noexpandtab
		autocmd FileType php set omnifunc=phpcomplete#CompletePHP
		autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
		autocmd FileType css set omnifunc=csscomplete#CompleteCSS
		autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

		" Enable lint checking for PHP files
		autocmd FileType php setlocal makeprg=php\ -l\ %
		autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
		autocmd FileType php let b:delimitMate_excluded_regions = "Comment,String,phpStringDouble,phpHereDoc,phpStringSingle,phpComment"
	augroup end "}}}

	augroup inform_files "{{{
		au!
		au BufNewFile,BufRead *.ni      setf inform7
		autocmd FileType inform7 setlocal foldtext=MyInformFoldText()
		autocmd FileType inform7 setlocal wrap
"
		"}}}
		
	augroup tads_files "{{{
		au!
		au BufNewFile,BufRead *.t      setf tads
        au FileType tads setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
		au FileType tads let b:delimitMate_nesting_quotes = ['"', "'"]
		au FileType tads let b:delimitMate_expand_cr = 1
		au FileType tads let b:MatchemEdgeCases = ['s:PythonTripleQuote']
"
		"}}}
	augroup markdown_files "{{{
		au!
		autocmd FileType markdown setlocal formatoptions-=tc

		"}}}
	augroup text_files "{{{
		au!
		autocmd FileType text setlocal formatoptions-=t
		autocmd FileType text setlocal formatoptions-=c

		"}}}

	" Restore cursor position upon reopening files {{{
	autocmd BufReadPost * 
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif
	" }}}


	augroup dcss_levdes "{{{
		au!
		au BufRead,BufNewFile *.des set syntax=levdes
	"}}}

endif
" }}}


