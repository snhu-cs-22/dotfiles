" Set options and add mapping such that Vim behaves a lot like MS-Windows,
" with some personal tweaks

finish

" Bail out if this isn't wanted.
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" " Set temp directories (https://vim.fandom.com/wiki/Fix_errors_that_relate_to_reading_or_creating_files_in_the_temp_or_tmp_environment_on_an_MS_Windows_PC)
" let $TEMP = "~/AppData/Local/Temp"
" let $TMP = "~/AppData/Local/Temp"
" set directory=.,$TMP,$TEMP

" Make default shell Windows PowerShell
set shell=powershell
set shellcmdflag=-c
" set noshelltemp

" " Make default shell Git Bash
" set shell=C:\Program\\\ Files\Git\usr\bin\bash.exe

" set shell=cmd.exe
" " set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive
" set shellcmdflag=/c
" set shellpipe=|
" set shellredir=>

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

if 1
    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" CTRL-V is paste in command line
cnoremap <C-V> <C-R>+

" Use CTRL-Q to do what CTRL-V used to do
" noremap <C-Q>		<C-V>

" Unmap CTRL-X as Cut
vunmap <C-X>

" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
" noremap <C-S>		:update<CR>
" vnoremap <C-S>		<C-C>:update<CR>gv
" inoremap <C-S>		<Esc>:update<CR>gi

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
