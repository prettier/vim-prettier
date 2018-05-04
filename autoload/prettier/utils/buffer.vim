function! prettier#utils#buffer#replace(lines, startSelection, endSelection) abort
  " store view
  let l:winview = winsaveview()
  let l:newBuffer = prettier#utils#buffer#createBufferFromUpdatedLines(a:lines, a:startSelection, a:endSelection)

  " we should not replace contents if the newBuffer is empty
  if empty(l:newBuffer)
    return
  endif

  " delete all lines on the current buffer
  silent! execute len(l:newBuffer) . ',' . line('$') . 'delete _'

  " replace all lines from the current buffer with output from prettier
  call setline(1, l:newBuffer)

  " Restore view
  call winrestview(l:winview)
endfunction

" Replace and save the buffer
function! prettier#utils#buffer#replaceAndSave(lines, startSelection, endSelection) abort
  call prettier#utils#buffer#replace(a:lines, a:startSelection, a:endSelection)
  write
endfunction

" Returns 1 if content has changed
function! prettier#utils#buffer#willUpdatedLinesChangeBuffer(lines, start, end) abort
  return getbufline(bufnr('%'), 1, line('$')) == prettier#utils#buffer#createBufferFromUpdatedLines(a:lines, a:start, a:end) ? 0 : 1
endfunction

" Returns a new buffer with lines replacing start and end of the contents of the current buffer
function! prettier#utils#buffer#createBufferFromUpdatedLines(lines, start, end) abort
  return getbufline(bufnr('%'), 1, a:start - 1) + a:lines + getbufline(bufnr('%'), a:end + 1, '$')
endfunction
