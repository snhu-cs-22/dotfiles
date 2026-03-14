" 1 Defaults {{{
set nocompatible

" set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent exe '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"}}}



" 2 Scripts/Plugins/Macros {{{

" Jump between matching tags using %
runtime macros/matchit.vim
packadd cfilter
packadd termdebug

" Load custom `mswin` plugin on Windows
" if !has('win32')
" 	g:skip_loading_mswin = v:true
" endif

" 2.1 Plugin-related {{{

" vim-airline
let g:airline_powerline_fonts = 1

" AutoComplPop
let g:acp_enableAtStartup = 1

" Colorizer
nnoremap <Leader>co <Cmd>ColorToggle<CR>

" NERDTree
let NERDTreeWinSize=50
let NERDTreeShowLineNumbers=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore=['cache[[dir]]']
nnoremap <Leader>n <Cmd>NERDTreeToggle<CR>
nnoremap <Leader>N <Cmd>NERDTreeToggle %:h<CR>

" neosnippets
" let g:neosnippet#snippets_directory = ""

" Oldfiles
" Close quickfix list when oldfile is opened
augroup oldfiles
	autocmd!
	autocmd FileType qf if get(w:, 'quickfix_title') =~# 'Oldfiles' | nnoremap <buffer> <CR> <CR>:cclose<CR> | endif
augroup END

" undotree
nnoremap <Leader>u <Cmd>UndotreeToggle<CR>

" fzf
nnoremap <Leader>e <Cmd>FZF<CR>

" vim-fugitive
nnoremap <Leader>gs <Cmd>Git<CR>
nnoremap <Leader>gI <Cmd>Git init<CR>
nnoremap <Leader>grf <Cmd>Git reflog<CR>
nnoremap <Leader>gbr <Cmd>Git branch -a<CR>
nnoremap <Leader>gbl <Cmd>Git blame<CR>
nnoremap <Leader>gBL <Cmd>Git blame -w -C -C -C<CR>

nnoremap <Leader>g2s <Cmd>Git bisect start
nnoremap <Leader>g2b <Cmd>Git bisect bad<CR>
nnoremap <Leader>g2g <Cmd>Git bisect good<CR>
nnoremap <Leader>g2o <Cmd>Git bisect old<CR>
nnoremap <Leader>g2n <Cmd>Git bisect new<CR>
nnoremap <Leader>g2r <Cmd>Git bisect reset<CR>

nnoremap <Leader>gdd <Cmd>Git diff<CR>
nnoremap <Leader>gDD <Cmd>Git diff --stat<CR>
nnoremap <Leader>gdmh <Cmd>Git diff main..HEAD<CR>
nnoremap <Leader>gdMh <Cmd>Git diff master..HEAD<CR>
nnoremap <Leader>gDmh <Cmd>Git diff --stat main..HEAD<CR>
nnoremap <Leader>gDMh <Cmd>Git diff --stat master..HEAD<CR>

nnoremap <Leader>gll <Cmd>Git log --decorate --oneline --graph<CR>
nnoremap <Leader>glm <Cmd>Git log --decorate --oneline --graph main^..HEAD<CR>
nnoremap <Leader>glM <Cmd>Git log --decorate --oneline --graph master^..HEAD<CR>
nnoremap <Leader>gl% <Cmd>Git log --decorate --oneline --graph --follow -- %<CR>
nnoremap <Leader>gLL <Cmd>Git log --decorate --oneline --graph --stat<CR>
nnoremap <Leader>gLm <Cmd>Git log --decorate --oneline --graph --stat main^..HEAD<CR>
nnoremap <Leader>gLM <Cmd>Git log --decorate --oneline --graph --stat master^..HEAD<CR>
nnoremap <Leader>gL% <Cmd>Git log --decorate --oneline --graph --follow -- %<CR>

nnoremap <Leader>grm <Cmd>Git rebase main<CR>
nnoremap <Leader>grM <Cmd>Git rebase master<CR>
nnoremap <Leader>grim <Cmd>Git rebase main -i --autosquash<CR>
nnoremap <Leader>griM <Cmd>Git rebase master -i --autosquash<CR>

nnoremap <Leader>gfo <Cmd>Git fetch origin<CR>
nnoremap <Leader>gplo <Cmd>Git pull origin<CR>
nnoremap <Leader>gpso <Cmd>Git push origin<CR>

nnoremap <Leader>gam <Cmd>Git absorb -b main -Fn<CR>
nnoremap <Leader>gaM <Cmd>Git absorb -b master -Fn<CR>
nnoremap <Leader>gAm <Cmd>Git absorb -b main -F<CR>
nnoremap <Leader>gAM <Cmd>Git absorb -b master -F<CR>

" vim-gitgutter
nmap <Leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <Leader>ghs <Plug>(GitGutterStageHunk)
nmap <Leader>ghu <Plug>(GitGutterUndoHunk)

" let g:polyglot_disabled = ['rust']

" vim-surround
" Anki cloze
let g:surround_{char2nr("c")} = "{{c\1number: \1::\r}}"
let g:surround_{char2nr("o")} = "[[oc\1number: \1::\r]]"

" vim-markdown (built-in)
let g:markdown_recommended_style = 0
let g:markdown_syntax_conceal = 1
let g:markdown_fenced_languages = ['mermaid']

" vsearch (vim.fandom.com/wiki/Search_for_visually_selected_text)
" Search for selected text, forwards or backwards.
vnoremap <silent> * <Cmd><C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # <Cmd><C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" vim-plug plugin manager (https://www.github.com/junegunn/vim-plug)

if executable('git')
	if has('win32')
		call plug#begin('~/vimfiles/plugged')
	elseif has('nvim')
		call plug#begin('~/.config/nvim/plugged')
	else
		call plug#begin('~/.vim/plugged')
	endif

	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" File browsing
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdtree'

	" Editing
	Plug 'tpope/vim-abolish'
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'godlygeek/tabular'

	" Shortcuts/keybinds
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'

	" Tweaks/wrappers
	Plug 'vim-scripts/AutoComplPop'
	Plug 'vim-airline/vim-airline'
	Plug 'BrandonRoehl/auto-omni'
	Plug 'tpope/vim-characterize'
	Plug 'tpope/vim-obsession'
	Plug 'gpanders/vim-oldfiles'
	Plug 'kshenoy/vim-signature' " Marks in gutter
	Plug 'mbbill/undotree'

	" Language support
	" Plug 'dense-analysis/ale'
	Plug 'tpope/vim-markdown'
	" Plug 'R-nvim/R.nvim'
	Plug 'sheerun/vim-polyglot'
	Plug 'PProvost/vim-ps1'

	" Misc.
    Plug 'chrisbra/Colorizer'
	Plug 'tpope/vim-dadbod'
	Plug 'vim-scripts/dbext.vim'

	call plug#end()
endif
"}}}

" 2.2 Custom Scripts/Autocommands (TODO: make these standalone plugins) {{{

" Auto-update recent files list
autocmd BufDelete * rviminfo!

" Resize splits when window size changes
autocmd VimResized * wincmd =

" 2.2.1 Session Options {{{
set sessionoptions=buffers,curdir,folds,help,globals,localoptions,resize,tabpages,winpos,winsize
" }}}

"}}}

" 2.3 Custom functions {{{
function ToggleFunction(on_function, off_function, status)
	" Protip: make sure to initialize your status variable before using this function

	" Evil string execution hackery to make this work with arbitrary function calls
	exe 'if !g:' . a:status
		exe 'call' a:on_function
		exe 'let g:' . a:status . '=1'
	else
		exe 'call' a:off_function
		exe 'let g:' . a:status . '=0'
	endif
endfunction
command -range -nargs=* ToggleFunction call ToggleFunction(<f-args>)

function MatchCount(pattern, range_start, range_end)
	redir => cnt
		silent exe a:range_start . ',' a:range_end . 's' . a:pattern . '/gn'
	redir END

	return strpart(l:cnt, 1, stridx(l:cnt, " "))
endfunction

" See also: v_g_CTRL-A
function SubWithSequence(find, replace, initial, incrementer, range_start, range_end)
	let l:current_num = a:initial
	let formatted_string = substitute(a:replace, "%", "%d", "")

	for i in range(a:range_start, a:range_end)
		for j in range(1, MatchCount(a:find, i, i))
			silent exe i . 's' . a:find . printf(l:formatted_string, l:current_num) . '/'
			let l:current_num += a:incrementer
		endfor
	endfor
endfunction
command -range -nargs=* SubWithSequence call SubWithSequence(<f-args>, <line1>, <line2>)
nnoremap <Leader>swn <Cmd>SubWithSequence /\<<C-r>=expand("<cword>")<CR>\>/<Space>
nnoremap <Leader>sWn <Cmd>SubWithSequence /\<<C-r>=expand("<cWORD>")<CR>\>/<Space>

" Inspired by: https://github.com/LukeSmithxyz/vimling/blob/master/plugin/ipa.vim
function SetAliases(dict)
	for i in keys(a:dict)
		exe 'inoremap' i a:dict[i]
	endfor
endfunction

function UnsetAliases(dict)
	for i in keys(a:dict)
		exe 'iunmap' i
	endfor
endfunction
" command -range -nargs=* ToggleAlias call ToggleFunction(<f-args>)

function! DeleteInactiveBufs()
	"From tabpagebuflist() help, get a list of all buffers in all tabs
	let tablist = []
	for i in range(tabpagenr('$'))
		call extend(tablist, tabpagebuflist(i + 1))
	endfor

	"Below originally inspired by Hara Krishna Dara and Keith Roberts
	"http://tech.groups.yahoo.com/group/vim/message/56425
	let nWipeouts = 0
	for i in range(1, bufnr('$'))
		if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
		"bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
			silent exec 'bwipeout' i
			let nWipeouts = nWipeouts + 1
		endif
	endfor
	echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()
"}}}
"}}}



" 3 Settings {{{

" 3.1 Visuals/Aesthetics/GUI {{{
filetype on
set lazyredraw
" language en
colorscheme retrobox
if has("gui_running")
	set guifont=Courier_New:h8:cDEFAULT:qDRAFT
endif

set number relativenumber
set numberwidth=6
set signcolumn=yes
set cursorline
set scrolloff=100
set sidescrolloff=24
" set scrollfocus
set virtualedit=block
set splitbelow splitright

set nowrap
set textwidth=0
set linebreak
set breakindent

" 3.1.1 Default statusline (overridden by vim-airline plugin) {{{
set laststatus=2
set statusline=
set statusline+=\ %n
set statusline+=\ %F
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ %L
"}}}
"}}}

" 3.2 File preferences/Buffer behavior {{{
set autoread
set clipboard^=unnamed,unnamedplus
set confirm
set hidden
set encoding=utf-8
set listchars=space:·,trail:-,nbsp:_,tab:——\|,precedes:\<,extends:\>,eol:$
set nrformats=bin,octal,hex
set nojoinspaces
set smartindent
set shiftwidth=4
set vartabstop=4
" set vartabstop=1,1,2,3,5,8,13,21,34,55,89,144
" set foldmethod=syntax
set foldopen=insert,jump,mark,quickfix,tag,undo
set nofoldenable
set foldcolumn=1
set nobackup
set noswapfile
" set noshelltemp
set writebackup
set exrc
set secure
"}}}

" 3.3 日本語サポート {{{
set formatoptions+=mM
set matchpairs+=（:）,「:」,『:』,《:》,〈:〉,｛:｝,［:］,【:】,‘:’,“:”,<:>
set spelllang=en,cjk
"}}}

" 3.4 Search {{{
set ignorecase smartcase
set nohlsearch
set incsearch
"}}}

" 3.5 Autocomplete {{{
set complete+=kspell
" set completeopt=noinsert,menu,menuone,preview,popup
set completeopt=noinsert,menu,menuone,preview
set omnifunc=syntaxcomplete#Complete
set shortmess+=c
"}}}

" 3.6 File browsing {{{

" Commands from "How to Do 90% of What Plugins Do (With Just Vim)"
" youtu.be.com/XA2WjJbmmoM
" https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
set wildignore=*.doc*,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.class,*.exe,*.flv,*.img,*.xls*,*.wav,*.mp3,*.ogg,*.avi

"}}}

set wildmode=longest,full

"}}}



" 4 Mappings/Keybinds {{{

" 4.1 Conveniences {{{
nnoremap Q q
nnoremap Y y$
nnoremap z<Space> za

" Override behavior of "gf" and create file even if it doesn't exist
nnoremap gf <Cmd>edit <cfile><CR>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Macro for jumping to and autocorrecting incorrect word to the first spellchecker option
nnoremap [z [s1z=
nnoremap ]z ]s1z=

" Remap ZZ to ask for confirmation before closing (consider unbinding)
nnoremap ZZ <Cmd>q<CR>

" Bind a similar key to ZZ, but for quitting all buffers (consider rebinding
" to something closer to the default behavior of ZZ)
nnoremap ZX <Cmd>qall<CR>
nnoremap ZC <Cmd>qall!<CR>

" Extension of vim-unimpared
nnoremap yoB <Cmd>windo setl scrollbind!<CR>
nnoremap ]t <Cmd>tabn<CR>
nnoremap [t <Cmd>tabp<CR>
nnoremap ]T <Cmd>tabmove +1<CR>
nnoremap [T <Cmd>tabmove -1<CR>

" " Map key chord `jk` to <Esc>.
" let g:esc_j_lasttime = 0
" let g:esc_k_lasttime = 0
" function! JKescape(key)
" 	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
" 	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
" 	let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
" 	return (l:timediff <= 0.05 && l:timediff >=0.001) ? "\b\e" : a:key
" endfunction
" inoremap <expr> j JKescape('j')
" inoremap <expr> k JKescape('k')

" Disable arrow movement, resize splits instead
nnoremap <Up> <C-W>-
nnoremap <Down> <C-W>+
nnoremap <Left> <C-W><
nnoremap <Right> <C-W>>

nnoremap <S-Up> <C-W>5-
nnoremap <S-Down> <C-W>5+
nnoremap <S-Left> <C-W>5<
nnoremap <S-Right> <C-W>5>
"}}}

" 4.2 Leader key commands {{{

" let mapleader = " "

" Identify the syntax highlighting group used at the cursor
" From: https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
nnoremap <F10> <Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Macro for automatically changing the case of the letter after a punctuation mark replacement (don't know whether to use or delete them)
nnoremap <Leader>r, r,wgulb
nnoremap <Leader>r; r;wgulb
nnoremap <Leader>r: r:wgulb
nnoremap <Leader>r. r.wgUlb
nnoremap <Leader>r! r!wgUlb
nnoremap <Leader>r? r?wgUlb

" Yank all, delete all
nnoremap <Leader>y <Cmd>%y<CR>
nnoremap <Leader>d <Cmd>%d_<CR>

" vimgrep last search (either in file, or in directory recursively)
nnoremap <Leader>vG <Cmd>vimgrep // **<CR>
nnoremap <Leader>vg <Cmd>vimgrep // %<CR>

" Read and Write Sessions to session directory
nnoremap <Leader>rs :ReadSession <C-R>=expand(g:sessionfile_dir)<CR>
nnoremap <Leader>ms :MakeSession <C-R>=expand(g:sessionfile_dir)<CR>
nnoremap <Leader>ws <Cmd>WriteCurrentSession<CR>
nnoremap <Leader>pcs <Cmd>echo g:current_session<CR>

" Set current directory to current buffer's directory
nnoremap <Leader>cd <Cmd>cd %:h\|pwd<CR>
" Set current directory to ".."
nnoremap <Leader>.. <Cmd>cd ..\|pwd<CR>

" Go back/forward to last file write
nnoremap <Leader>fe <Cmd>earlier 1f<CR>
nnoremap <Leader>fl <Cmd>later 1f<CR>

" Insert date and time with current formatting
nnoremap <F5> "=strftime("%D")<CR>p
inoremap <F5> <C-R>=strftime("%D")<CR>
nnoremap <F6> "=strftime("%T")<CR>p
inoremap <F6> <C-R>=strftime("%T")<CR>

" 4.2.1 Quick shell commands {{{
" 4.2.1.1 Interpreters/Compilers {{{
" Run Python interpreter on current file
nnoremap <Leader>py <Cmd>!python \"%\" &<CR>
" }}}

" Pretty print json using Python tool
nnoremap <Leader>json <Cmd>%!python -m json.tool<CR>

" Convert to different formats via pandoc
nnoremap <Leader>pdd <Cmd>!pandoc -i \"%\" -o \"%:s/\..*$/\.docx/\" &<CR>
nnoremap <Leader>pdh <Cmd>!pandoc -i \"%\" -o \"%:s/\..*$/\.html/\" &<CR>
nnoremap <Leader>pdl <Cmd>!pandoc -i \"%\" -o \"%:s/\..*$/\.latex/\" &<CR>
nnoremap <Leader>pdt <Cmd>!pandoc -i \"%\" -o \"%:s/\..*$/\.tex/\" &<CR>
nnoremap <Leader>pdp <Cmd>!pandoc -i \"%\" -o \"%:s/\..*$/\.pdf/\" &<CR>

" Delete file in current buffer
" nnoremap <Leader>rm <Cmd>!rm \"%\"<CR>
nnoremap <Leader>rm <Cmd>echo delete(expand("%"))<CR>

" Open current file/url with default handler
nnoremap <Leader>of <Cmd>!xdg-open "%" &<CR>
" Open file/url under cursor with default handler
nnoremap <Leader>oF <Cmd>!xdg-open "<cfile>" &<CR>

" Open directory of current buffer
nnoremap <Leader>od <Cmd>!xdg-open "%:h" &<CR>
" Open folder of current working directory
nnoremap <Leader>owd <Cmd>!xdg-open <C-r>=getcwd()<CR>&<CR>
" }}}

" 4.2.2 Quick substitutions {{{
" Show number of instances of last pattern
nnoremap <Leader>sn <Cmd>%s///gn<CR>
vnoremap <Leader>sn <Cmd>s///gn<CR>

" Remove trailing whitespace
nnoremap <Leader>st <Cmd>%s/\s\+$//g<CR>
vnoremap <Leader>st <Cmd>s/\s\+$//g<CR>

" Change back slashes to front slashes
nnoremap <Leader>s/ <Cmd>%s.\\.\/.g<CR>
vnoremap <Leader>s/ <Cmd>s.\\./.g<CR>
nnoremap <Leader>s\ <Cmd>%s.\/.\\.g<CR>
vnoremap <Leader>s\ <Cmd>s.\/.\\.g<CR>

" Join lines in paragraph (https://stackoverflow.com/a/5651510)
nnoremap <Leader>sJp <Cmd>%s/\(\S\)\n\(\S\)/\1 \2/g<CR>
vnoremap <Leader>sJp <Cmd>s/\(\S\)\n\(\S\)/\1 \2/g<CR>

" Turn into "Title Caps" (Stolen from Vim documentation. See: case)
nnoremap <Leader>sU <Cmd>s/\v<(.)(\w*)/\u\1\L\2/
vnoremap <Leader>sU <Cmd>s/\v<(.)(\w*)/\u\1\L\2/g<CR>

" Turn "smart quotes" into regular quotes
nnoremap <Leader>sq <Cmd>%s/“\\|”/"/g\|%s/‘\\|’/'/g<CR>
vnoremap <Leader>sq <Cmd>s/“\\|”/"/g\|s/‘\\|’/'/g<CR>

" Turn regular quotes into "smart quotes"
nnoremap <Leader>sQ <Cmd>%s/\s\@<="\S\@<=/“/g\|:%s/\S\@<="/”/g\|:%s/\s\@<='\S\@<=/‘/g\|:%s/\S\@<='/’/g<CR>
vnoremap <Leader>sQ <Cmd>s/\s\@<="\S\@<=/“/g\|:s/\S\@<="/”/g\|:s/\s\@<='\S\@<=/‘/g\|:s/\S\@<='/’/g<CR>

" Put periods, commas inside the quotation mark (American style)
nnoremap <Leader>s' <Cmd>%s/\("\\|'\\|”\\|’\)\(\.\\|,\)/\2\1/g<CR>
vnoremap <Leader>s' <Cmd>s/\("\\|'\\|”\\|’\)\(\.\\|,\)/\2\1/g<CR>
" Put periods, commas outside the quotation mark (International style)
nnoremap <Leader>s" <Cmd>%s/\(\.\\|,\)\("\\|'\\|”\\|’\)/\2\1/g<CR>
vnoremap <Leader>s" <Cmd>s/\(\.\\|,\)\("\\|'\\|”\\|’\)/\2\1/g<CR>

" Remove Anki clozes
nnoremap <Leader>s] <Cmd>%s/{{c\d\{-}::\(.\{-}\)}}/\1/g<CR>
vnoremap <Leader>s] <Cmd>s/{{c\d\{-}::\(.\{-}\)}}/\1/g<CR>

" Change Markdown Links to <a> tags
nnoremap <Leader>sa <Cmd>%s/\[\(.\{-}\)\](\(.\{-}\))/<a href="\2">\1<\/a>/g<CR>
vnoremap <Leader>sa <Cmd>s/\[\(.\{-}\)\](\(.\{-}\))/<a href="\2">\1<\/a>/g<CR>

"}}}

" 4.2.3 Quick searches {{{
" Hex colors
noremap <Leader>/# /#\x\{8}\\|#\x\{6}\\|#\x\{3}<CR>
"}}}
"}}}
"}}}
