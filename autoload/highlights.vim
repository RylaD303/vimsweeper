function! InitHighlight()
    syntax match bomb "\*"
    syntax match border "|\|+\|-\|#"
    syntax match empty " "
    syntax match gameover "Game over!"
  
    highlight link bomb Error
    highlight link empty Identifier
    highlight link border Comment
    highlight link over Title
  
    setlocal nocursorline
    setlocal buftype=nofile
  endfunction