function! prettier#utils#buffer#replace(lines, startSelection, endSelection) abort
  " store view
  let l:winview = winsaveview()
  let l:newBuffer = prettier#utils#buffer#createBufferFromUpdatedLines(a:lines, a:startSelection, a:endSelection)

  " we should not replace contents if the newBuffer is empty
  if empty(l:newBuffer)
    return
  endif

  " https://vim.fandom.com/wiki/Restore_the_cursor_position_after_undoing_text_change_made_by_a_script
  " create a fake change entry and merge with undo stack prior to do formating
  execute "normal! i "
  execute "normal! a\<BS>"
  try | silent undojoin | catch | endtry

  " insert all lines from prettier-ed buffer before the first line on the current buffer
  silent! lockmarks call append(0, l:newBuffer)

  " then delete all the original lines on the current buffer
  silent! lockmarks execute (len(l:newBuffer) + 1).',$delete _'

  " Restore view
  call winrestview(l:winview)

endfunction

" Replace and save the buffer
function! prettier#utils#buffer#replaceAndSave(lines, startSelection, endSelection) abort
  call prettier#utils#buffer#replace(a:lines, a:startSelection, a:endSelection)
  noautocmd write
endfunction

" Returns 1 if content has changed
function! prettier#utils#buffer#willUpdatedLinesChangeBuffer(lines, start, end) abort
  return getbufline(bufnr('%'), 1, line('$')) == prettier#utils#buffer#createBufferFromUpdatedLines(a:lines, a:start, a:end) ? 0 : 1
endfunction

" Returns a new buffer with lines replacing start and end of the contents of the current buffer
function! prettier#utils#buffer#createBufferFromUpdatedLines(lines, start, end) abort
  return getbufline(bufnr('%'), 1, a:start - 1) + a:lines + getbufline(bufnr('%'), a:end + 1, '$')
endfunction

" Adapted from https://github.com/farazdagi/vim-go-ide
function! s:getCharPosition(line, col) abort
    if &encoding !=# 'utf-8'
        " On utf-8 enconding we can't just use bytes so we need to make sure we can count the
        " characters, we do that by adding the text into a temporary buffer and counting the chars
        let l:buf = a:line == 1 ? '' : (join(getline(1, a:line - 1), "\n") . "\n")
        let l:buf .= a:col == 1 ? '' : getline('.')[:a:col - 2]
        return len(iconv(l:buf, &encoding, 'utf-8'))
    endif
    " On non utf-8 the line byte should match the character
    return line2byte(a:line) + (a:col - 2)
endfun

" Return the start byte when on visual mode
function! prettier#utils#buffer#getCharRangeStart(startSelection) abort
  return s:getCharPosition(a:startSelection, col("'<"))
endfunction

" Return the end byte when on visual mode
function! prettier#utils#buffer#getCharRangeEnd(endSelection) abort
  return s:getCharPosition(a:endSelection, col("'>"))
endfunction
