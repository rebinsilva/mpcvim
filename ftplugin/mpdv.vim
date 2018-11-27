set buftype=nofile
setlocal statusline=%!GetMPCStatusline()
setlocal conceallevel=3
setlocal concealcursor=nvic

function! GetMPCStatusline()
	let cmd="mpc status"
	let result=split(system(cmd),'\n')

	let status = len(result) == 3 ? result[2] : result[0]

	let [s:count, s:settings] =
	\	[len(split(system('mpc playlist'),'\n')),
	\	split(status,' ')]

	let s:statusline=" repeat: "
	\	. s:settings[4] . " --- random: "
	\	. s:settings[8] . "---%="
	\	. s:count . " songs"

	return s:statusline
endfunction

command! -buffer PlaySelectedSong call mpc#PlaySong(line("."))
command! -buffer ToggleRandom call mpc#ToggleRandom()
command! -buffer ToggleRepeat call mpc#ToggleRepeat()

nnoremap <silent> <buffer>	<c-x>	:PlaySelectedSong<cr>
nnoremap <silent> <buffer>	<c-a>	:ToggleRandom<cr>
nnoremap <silent> <buffer>	<c-e>	:ToggleRepeat<cr>
