let s:PREFIX_MSG = 'Prettier: '
let s:ERRORS = {
  \ 'EXECUTABLE_NOT_FOUND_ERROR': 'no prettier executable installation found',
  \ 'PARSING_ERROR': 'failed to parse buffer',
  \ }
let s:DEFAULT_ERROR = get(s:, 'PARSING_ERROR')

function! prettier#logging#error#log(...) abort
  let l:error = a:0 > 0 ? a:1 : s:DEFAULT_ERROR
  let l:msg = a:0 > 1 ? ': ' . a:2 : ''
  echohl WarningMsg | echom s:PREFIX_MSG . get(s:ERRORS, l:error, s:DEFAULT_ERROR) . l:msg | echohl NONE
endfunction
