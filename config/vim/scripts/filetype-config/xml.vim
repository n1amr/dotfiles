setlocal syntax=xml

let b:indent_width = 2
call IndentWidth(b:indent_width)

let &formatexpr = "FormatXml(v:lnum, v:count)"

function! FormatXml(lnum, count)
  execute '%!xmllint --format -'
endfunction
