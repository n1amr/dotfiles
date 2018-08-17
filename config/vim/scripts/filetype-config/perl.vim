setlocal syntax=perl

let b:run_expr = 'call RunPerl()'

function! RunPerl()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && perl ' . l:fpath
endfunction

let &formatexpr = "FormatPerl(v:lnum, v:count)"

function! FormatPerl(lnum, count)
  let l:from = a:lnum
  let l:to = a:lnum + a:count - 1
  execute l:from . ',' . l:to . '!perltidy -q --indent-columns=4 --maximum-line-length=120'
  " . ' --entab-leading-whitespace=4'
endfunction
