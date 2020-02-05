" TODO
" this function should just returns the parsed errors list instead
" of opening the quickfix
function! prettier#bridge#parser#onError(out, autoFocus) abort
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
    call prettier#utils#quickfix#open(l:errors, a:autoFocus)
  endif
endfunction
