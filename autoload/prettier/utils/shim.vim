" Backwards compatable version of shiftwidth()
function! prettier#utils#shim#shiftwidth() abort
  if exists('*shiftwidth')
    return shiftwidth()
  else
    return &shiftwidth
  endif
endfunction
