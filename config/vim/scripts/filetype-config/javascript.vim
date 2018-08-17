setlocal syntax=javascript

let b:indent_width = 2
call IndentWidth(b:indent_width)

let b:run_expr = 'call RunJavaScript()'

function! RunJavaScript()
  update!
  let l:fpath = shellescape(expand('%'))
  execute '!clear && js ' . l:fpath
endfunction

let &formatexpr = "FormatJavaScript(v:lnum, v:count)"

function! FormatJavaScript(lnum, count)
  let l:from = a:lnum
  let l:to = a:lnum + a:count - 1
  execute l:from . ',' . l:to . '!js-beautify -s ' . b:indent_width . ' -'
endfunction

