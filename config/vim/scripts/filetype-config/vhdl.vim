setlocal syntax=vhdl
 
let b:indent_width = 2
call IndentWidth(b:indent_width)

let b:run_expr = 'call RunVHDL()'

function! RunVHDL()
  update!
  let l:fpath = shellescape(expand('%'))
  silent execute '!clear && while true; do if [ -f Makefile ]; then break; else cd ..; fi; done && make view; echo -ne "\nPress enter to continue..." && read'
  redraw!
endfunction
