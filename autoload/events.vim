function! InitEvents()
  augroup UpdateGame
    autocmd!
    autocmd CursorHold * call Update()
  augroup END

  augroup LeaveGame
    autocmd!
    autocmd BufLeave * autocmd! UpdateGame CursorHold *
  augroup END
endfunction


function! SaveAndOpenNewBuffer()
  if filereadable(bufname('%'))
    exec "w"
  endif

  exec "enew"
endfunction