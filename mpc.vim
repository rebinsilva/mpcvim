function! OpenMPC()
	let cmd= "mpc --format '%position% %artist / %album% / %title%' current"
	echomsg system(cmd)[:-2]
endfunction

function! ListMPC()
	let cmd="mpc --format '%position% %artist% / %album% / %title%' playlist"
	let playlist=split(system(cmd),'\n')

	new

	for track in playlist
		if(track==playlist[0])
			execute "normal! I".track
		else
			call append(line('$'),track)
		endif
	endfor
endfunction
