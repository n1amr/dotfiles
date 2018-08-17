setlocal syntax=python

let b:run_expr = 'call RunPython()'

function! RunPython()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && python ' . l:fpath
endfunction

let &formatexpr = "FormatPython(v:lnum, v:count)"

function! FormatPython(lnum, count)
  let l:from = a:lnum
  let l:to = a:lnum + a:count - 1
  execute l:from . ',' . l:to . '!autopep8 -'
endfunction
