setlocal syntax=tex

let b:indent_width = 2
call IndentWidth(b:indent_width)

let b:run_expr = 'call RunTex()'

function! RunTex()
  update!
  let l:fpath = shellescape(expand('%'))
  let l:pdfpath = substitute(l:fpath, '\..*$', ".pdf'", '')
  silent execute '!clear && latexmk -silent -gg --pdf ' . l:fpath . ' && latexmk -c && gui-open ' . l:pdfpath . ' && latexmk -c'
  redraw!
endfunction
