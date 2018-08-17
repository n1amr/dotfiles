setlocal syntax=cpp

let b:indent_width = 2
call IndentWidth(b:indent_width)

let b:run_expr = 'call CompileRunCPP()'

function! CompileRunCPP()
  update!
  let buildpath = systemlist('dirname ' . shellescape(expand('%')))[0] . '/build'

  silent execute '!clear'
  silent execute '!mkdir -pv ' . shellescape(buildpath)
  execute '!cd ' . shellescape(buildpath) . ' && cmake .. && make && clear && ./main'
endfunction
