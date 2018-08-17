setlocal syntax=sh

let b:run_expr = 'call RunBash()'

function! RunBash()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && bash ' . l:fpath
endfunction
