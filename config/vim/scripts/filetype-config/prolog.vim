setlocal syntax=prolog

let b:run_expr = 'call RunProlog()'

function! RunProlog()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && swipl -qf ' . l:fpath . ' -t main.'
endfunction
