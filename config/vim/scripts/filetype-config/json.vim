setlocal syntax=json

let b:indent_width = 2
call IndentWidth(b:indent_width)

let &formatexpr = "FormatJson(v:lnum, v:count)"

function! FormatJson(lnum, count)
  execute '%!jq .'
endfunction
