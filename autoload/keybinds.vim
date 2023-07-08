function! ClearUnnededBinds()
  mapclear <buffer>

  for key in ['i', 'v', 'c', 'x', 'd']
    exec 'map <buffer> ' . key . ' <nop>'
    exec 'map <buffer> ' . toupper(key) . ' <nop>'
  endfor
endfunction

function! InitBinds()
  call ClearUnnededBinds()

  map <silent> <buffer> h :call MoveLeft()<CR>
  map <silent> <buffer> j :call MoveDown()<CR>
  map <silent> <buffer> k :call MoveUp()<CR>
  map <silent> <buffer> l :call MoveRight()<CR>
  map <silent> <buffer> r :call Reveal()<CR>
  map <silent> <buffer> f :call Flag()<CR>
endfunction

"function! Write(symbol)
"  echo strcharpart(getline('.')[col('.') - 1:], 0, 1)
"  if index(['|', '+', '-'], strcharpart(getline('.')[col('.') - 1:], 0, 1)) >= 0
"    return
"  endif
"
"  exec 'normal! r' . a:symbol
"endfunction