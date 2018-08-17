setlocal syntax=make

setlocal noexpandtab

let b:run_expr = 'call RunMake()'

function! RunMake()
  execute '!clear && make'
endfunction
