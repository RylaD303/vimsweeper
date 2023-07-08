let s:path = expand('<sfile>:p:h')

let s:imports = ['render', 'keybinds', 'events', 'highlights']

for import in s:imports
  exec 'source' . s:path . '/' . import . '.vim'
endfor

pyx import vim
exec 'pyxfile' s:path . '/../pythonx/level_reader.py'

function! OpenLevel(level_path)

  pyx rows, columns, bombs, numbers, revealed = get_level_data(vim.eval("a:level_path"))
  pyx vim.command("let s:rows = eval('%s')" % rows)
  pyx vim.command("let s:columns = eval('%s')" % columns)
  pyx vim.command("let s:bombs = eval('%s')" % bombs)
  pyx vim.command("let s:numbers = eval('%s')" % numbers)
  pyx vim.command("let s:revealed_spaces = eval('%s')" % revealed)
  let s:flags = []

  return 0
endfunction

function! vimsweeper#Start( ... )
  let l:level_path = s:path . '/../default_level.txt'
  call OpenLevel(l:level_path) 
  call SaveAndOpenNewBuffer()

  let s:started = 0
  let s:game_over = 0
  let s:current_position_x = 1
  let s:current_position_y = 1

  call InitHighlight()
  call InitEvents()
  call InitBinds()
  call Update()
endfunction

function! MoveLeft()
  let s:current_position_y = s:current_position_y - 1
  if s:current_position_y == 0
    let s:current_position_y = 1
  endif
endfunction

function! MoveRight()
    let s:current_position_y = s:current_position_y + 1
    if s:current_position_y == s:columns+1
      let s:current_position_y = s:columns
    endif
endfunction

function! MoveUp()
    let s:current_position_x = s:current_position_x -1
    if s:current_position_x == 0
      let s:current_position_x = 1
    endif
endfunction

function! MoveDown()
    let s:current_position_x = s:current_position_x + 1
    if s:current_position_x == s:rows+1
      let s:current_position_x = s:rows
    endif
endfunction


function! Flag()
    let s:probable_flag = index(s:flags, [s:current_position_x, s:current_position_y])
    if s:probable_flag>=0
        call remove(s:flags, s:probable_flag)
    else
        call insert(s:flags, [s:current_position_x, s:current_position_y])
    endif
    call Update()
endfunction

function Reveal()
    if index(s:bombs, [s:current_position_x, s:current_position_y]) >= 0
        let s:game_over = 1
    else
        call RevealSpot()
    endif
    call Update()
endfunction

function RevealSpot()
    let s:queue = []
    call insert(s:queue, [s:current_position_x, s:current_position_y])
    while len(s:queue) > 0
        let s:element = s:queue[0]
        call remove(s:queue, 0)
        if s:element[0] >= 0 && s:element[0] <20 && s:element[1] >= 0 && s:element[1]<20 && s:revealed_spaces[s:element[0]][s:element[1]] == 0
            let s:revealed_spaces[s:element[0]][s:element[1]] = 1

            if s:numbers[s:element[0]][s:element[1]] == 0
                call insert(s:queue, [s:element[0]+1, s:element[1]])
                call insert(s:queue, [s:element[0], s:element[1]+1])
                call insert(s:queue, [s:element[0]-1, s:element[1]])
                call insert(s:queue, [s:element[0], s:element[1]-1])
            endif
        endif
    endwhile
endfunction

function! Update()
  if s:game_over == 1
    return
  endif

  call DrawBorders(s:rows, s:columns)
  call DrawStatus(s:started, s:game_over)
  call DrawFlags(s:flags)
  call DrawNumbers(s:revealed_spaces,  s:numbers)
endfunction
