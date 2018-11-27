function! mpc#CurrentMPC()
	let cmd= "mpc --format '%position% %artist% / %album% / %title%' current"
	echomsg system(cmd)[:-2]
endfunction

function! mpc#GetPlaylist()
	let command="mpc --format '%position% @%artist% @%album% @%title%' playlist"
	let [results,playlist]=[split(system(command),'\n'),[]]
	let maxLengths={'position': [],'artist': [],'album': []}

	for item in results
		call add(playlist,mpc#EncodeString(item))
	endfor

	for track in playlist
		call add(maxLengths['position'],len(track.position))
		call add(maxLengths['artist'],len(track.artist))
		call add(maxLengths['album'],len(track.album))
	endfor

	call sort(maxLengths.position,"LargestNumber")
	call sort(maxLengths.artist,"LargestNumber")
	call sort(maxLengths.album,"LargestNumber")

	for track in playlist
		if(maxLengths.position[-1]+1>len(track.position))
			let track.position = repeat(' ',
			\	maxLengths.position[-1]-len(track.position))
			\	. track.position
		endif

		let track.position .=' '
		let track.artist .= repeat(' ',maxLengths['artist'][-1]+2-len(track.artist))
		let track.album .= repeat(' ',maxLengths['album'][-1]+2-len(track.album))
	endfor

	return playlist
endfunction

function! LargestNumber(no1,no2)
	return a:no1==a:no2?0:a:no1>a:no2?1:-1
endfunction

function! mpc#ListMPC()
	let playlist=mpc#GetPlaylist()

	for track in playlist
		let output=track.position." "
		\	.track.artist
		\	.track.album
		\	.track.title
		if(track.position==playlist[0].position)
			execute "normal! 1GdGI".output
		else
			call append(line('$'),output)
		endif
	endfor
endfunction

function! mpc#EncodeString(item)
	let item= split(a:item," @")
	let song={'position':item[0],
	\	'artist':'@ar'.item[1].'ar@',
	\	'album':'@al'.item[2].'al@',
	\	'title':'@ti'.item[3].'ti@'}

	return song
endfunction

function! mpc#DecodeString(item)
	let line_items=split(substitute(a:item, ' \{2,},' ','g'),' @')
	let song={'position':line_items[0],
	\	'artist':line_items[1][2:-4],
	\	'album':line_items[2][2:-4],
	\	'title':line_items[3][2:-4]}

	return song
endfunction

function! mpc#TogglePlayback()
	let command='mpc toggle'
	let result=split(system(command),'\n')[1]

	let message='[mpc] '
	let message .= split(result,' ')[0]=='[paused]'?'PAUSED':'PLAYING'
	echomsg message
endfunction

function! mpc#ToggleRandom()
	let command='mpc random'
	let result=split(system(command),'\n')
	let status = len(result) ==3?result[2]:result[0]
	let restatus=split(status,' ')

	let message=(restatus[8]=='off' || restatus[9]=='off')
	\	?'[mpc] RANDOM: OFF':'[mpc] RANDOM: ON'
	echomsg message
endfunction

function! mpc#ToggleRepeat()
	let command='mpc repeat'
	let result=split(system(command),'\n')
	let status=len(result)==3?result[2]:result[0]
	let message=split(status,' ')[4]=='off'
	\	?'[mpc] REPEAT: OFF':'[mpc] REPEAT: ON'
	echomsg message
endfunction
function! mpc#PlaySong(no)
let song = split(getline(a:no), " ")
let results = split(system("mpc --format '%title% (%artist%)' play "
\ . song[0]), "\n")
let message = '[mpc] NOW PLAYING: ' . results[0]
echomsg message
endfunction
