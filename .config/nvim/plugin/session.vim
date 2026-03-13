" Default values
if has('win32')
	let s:vimdir = '~/vimfiles/'
elseif has('nvim')
	let s:vimdir = '~/.config/nvim/'
else
	let s:vimdir = '~/.vim/'
endif
let g:sessionfile_dir = s:vimdir .. 'session/'
let g:sessionfile_autosave = v:true

function! ReadSession(file)
	if exists("g:current_session")
		if g:current_session ==# a:file
			echo printf('Session "%s" is already loaded.', a:file)
			return
		else
			bd *
			silent argd*
		endif
	endif

	" Read the session
	exe 'source' a:file
	let g:current_session = a:file

	" Workaround for switching to the first file in the Vim arguments
	if argc(-1) > 0 && bufloaded(argv(0))
		exe 'buffer' argv(0)
	endif

	" Workaround for starting Vim GUI maximized
	" TODO: only turn this on for window sizes close to maximized sizes
	if has("gui_running")
		simalt ~x
	endif

	if g:sessionfile_autosave
		autocmd VimLeave * argd*
		autocmd VimLeave * call WriteCurrentSession()
	endif
endfunction

function! MakeSession(file)
	exe 'mksession!' a:file
	let g:current_session = a:file
	echo printf('New session saved at "%s".', a:file)
endfunction

function! WriteCurrentSession()
	exe 'mksession!' g:current_session
	echo printf('Saved current session "%s".', g:current_session)
endfunction

command! -nargs=1 -complete=file ReadSession call ReadSession(<f-args>)
command! -nargs=1 -complete=file MakeSession call MakeSession(<f-args>)
command! WriteCurrentSession call WriteCurrentSession()
