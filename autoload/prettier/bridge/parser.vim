function! prettier#bridge#parser#onError(out) abort
  let l:errors = []

  for l:line in a:out
    " matches:
    " file.ext: SyntaxError: Unexpected token (2:8)sd
    " stdin: SyntaxError: Unexpected token (2:8)
    " [error] file.ext: SyntaxError: Unexpected token (2:8)
    let l:match = matchlist(l:line, '^.*: \(.*\) (\(\d\{1,}\):\(\d\{1,}\)*)')
    if !empty(l:match)
      call add(l:errors, { 'bufnr': bufnr('%'),
                         \ 'text': l:match[1],
                         \ 'lnum': l:match[2],
                         \ 'col': l:match[3] })
    endif
  endfor

  if len(l:errors)
    let l:winnr = winnr()
    call setqflist(l:errors, 'r')
    botright copen
    if !g:prettier#quickfix_auto_focus
      " Return the cursor back to the main buffer.
      exe l:winnr . 'wincmd w'
    endif
    return 1
  endif
endfunction
