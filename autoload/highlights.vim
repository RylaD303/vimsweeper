function! InitHighlight()
    syntax match bomb "\*"
    syntax match border "|\|0\|-\|#"
    syntax match empty "\."
    syntax match gameover "Game over!"
    syntax match flag "P"
  
    highlight link bomb Error
    highlight link empty Identifier
    highlight link border Comment
    highlight link over Title
    highlight link flag Warning

    setlocal nocursorline
    setlocal buftype=nofile
  endfunction
