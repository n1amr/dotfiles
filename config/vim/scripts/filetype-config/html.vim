setlocal syntax=html

let b:indent_width = 2
call IndentWidth(b:indent_width)

let &formatexpr = "FormatHTML(v:lnum, v:count)"

function! FormatHTML(lnum, count)
  execute 'silent %!tidy -mi -wrap 0 -q --show-errors 0 --tidy-mark no'
endfunction
