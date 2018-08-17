setlocal syntax=zsh

let b:run_expr = 'call RunZsh()'

function! RunZsh()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && zsh ' . l:fpath
endfunction
