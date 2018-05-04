" We use this flag so that we ensure only clearing quickfix if it was created by prettier itself
let s:prettier_quickfix_open = 0

function! prettier#utils#quickfix#close() abort
  " close quickfix if it is opened
  if s:prettier_quickfix_open
    call setqflist([], 'r')
    cclose
    let s:prettier_quickfix_open = 0
  endif
endfunction

function! prettier#utils#quickfix#open(errors, focus) abort
  let s:prettier_quickfix_open = 1
  let l:winnr = winnr()
  call setqflist(a:errors, 'r')
  botright copen
  if !a:focus
    " Return the cursor back to the main buffer.
    exe l:winnr . 'wincmd w'
  endif
endfunction
