function! OpenMPC()
	call system("mpc play")
	call mpc#CurrentMPC()
endfunction

function! DisplayList()
	if bufexists("mpc.mpdv")
		let mpcwin=bufwinnr("mpc.mpdv")
		if(mpcwin == -1)
			execute "sbuffer ".bufnr("mpc.mpdv")
			return
		else
			execute mpcwin."wincmd w"
			return
		endif
	else
		execute "new mpc.mpdv"
	endif
	call mpc#ListMPC()
endfunction

command! MpcBrowser call OpenMPC()
command! TogglePlayback call mpc#TogglePlayback()
command! DisplayList call DisplayList()

nnoremap <silent> 		<plug>MpcToggleplayback :TogglePlayback<cr>
if !hasmapto("<plug>MpcToggleplayback")
	nmap <leader>mt <plug>MpcToggleplayback
endif


nnoremap <silent> 		<plug>MpcDisplayList :DisplayList<cr>
if !hasmapto("<plug>MpcDisplayList")
	nmap <leader>md <plug>MpcDisplayList
endif
