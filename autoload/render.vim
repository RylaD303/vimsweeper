function! DrawNumbers(revealed_spaces, numbers)
    let l:i = 0
    while l:i < len(a:numbers)
        let l:j = 0
        while l:j < len(a:numbers[0])
            if a:numbers[l:i][l:j]>0 && a:revealed_spaces[l:i][l:j]==1
                call DrawNumber(a:numbers[l:i][l:j], [l:i, l:j])
	    elseif a:revealed_spaces[l:i][l:j]==1
	        call DrawSpace(l:i, l:j)
            endif
	    let l:j = l:j + 1
        endwhile
	let l:i = l:i + 1
    endwhile
endfunction

function! DrawSpace(x, y)
    call cursor(a:x + 2, a:y + 2)
    normal! r.
endfunction

function! DrawNumber(number, pos)
    if a:number == 1
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r1
    endif
    if a:number == 2
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r2
    endif
    if a:number == 3
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r3
    endif
    if a:number == 4
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r4
    endif
    if a:number == 5
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r5
    endif
    if a:number == 6
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r6
    endif
    if a:number == 7
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r7
    endif
    if a:number == 8
        call cursor(a:pos[0] + 2, a:pos[1] + 2)
        normal! r8
    endif
endfunction

function! DrawCursor(x, y)
    call cursor(a:x + 2, a:y + 2)
    normal! r#
endfunction

function! SaveAndOpenNewBuffer()
    if filereadable(bufname('%'))
      exec "w"
    endif
  
    exec "enew"
endfunction

function! DrawStatus(started, game_over)
    if a:started == 0
        call append(line('$'), "Press h,j,k or l to start")
    elseif a:game_over == 1
        call append(line('$'), "Game over!")
    endif
endfunction

function! DrawFlags(flags)
    for flag in a:flags
        call cursor(flag[0]+2, flag[1]+2)
	normal! rP
    endfor
endfunction

function! DrawBorders(rows, columns)
    silent normal! ggdG
    let l:space = "|"
    let l:border = "0"
  
    let l:i = 1
    while l:i <= a:columns
        let l:space = l:space . " "
        let l:border = l:border . "-"
        let l:i = l:i + 1
    endwhile
  
    let l:space = l:space . "|"
    let l:border = l:border . "0"
    let l:i = 1
  
    call setline(1, l:border) 
  
    while l:i <= a:rows
        call append(line('$'), l:space)
        let l:i = l:i + 1
    endwhile
  
    call append(line('$'), l:border)
endfunction
