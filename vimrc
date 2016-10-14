color dracula

set number
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set smartindent

noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp
