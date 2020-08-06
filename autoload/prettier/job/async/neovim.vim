let s:prettier_job_running = 0

function! prettier#job#async#neovim#run(cmd, startSelection, endSelection) abort
  if s:prettier_job_running == 1
    return
  endif
  let s:prettier_job_running = 1

  let l:lines = getline(a:startSelection, a:endSelection)
  let l:dict = {
        \ 'start': a:startSelection - 1,
        \ 'end': a:endSelection,
        \ 'buf_nr': bufnr('%'),
        \ 'content': l:lines,
        \}
  let l:out = []
  let l:err = []

  let l:job = jobstart([&shell, &shellcmdflag, a:cmd], {
    \ 'stdout_buffered': 1,
    \ 'stderr_buffered': 1,
    \ 'on_stdout': {job_id, data, event -> extend(l:out, data)},
    \ 'on_stderr': {job_id, data, event -> extend(l:err, data)},
    \ 'on_exit': {job_id, status, event -> s:onExit(status, l:dict, l:out, l:err)},
    \ })
  call jobsend(l:job, l:lines)
  call jobclose(l:job, 'stdin')
endfunction

" todo
" Lets refactor this onExit to work similar to our solution for vim8
" at the moment an info json object is been passed with some cached data
" that is than used to do the formatting, its not following the same convetion
" as the vim8 one and is error prone
"
" we should:
"
" 1. make it similar to the vim8 approach
" 2. extract common functionality either above to the runner or to some other module
"
" to test this it rellies on using nvim and having the flag 
"
"  note that somehow we exectuing both async and sync on nvim when using the autoformat
function! s:onExit(status, info, out, err) abort
  if len(a:out) == 0 | return | endif

  let l:currentBufferNumber =  bufnr('%')
  let l:isInsideAnotherBuffer = a:info.buf_nr != l:currentBufferNumber ? 1 : 0
  let l:last = a:out[len(a:out) - 1]
  let l:out = l:last ==? '' ? a:out[0:len(a:out) - 2] : a:out

  " parsing errors
  if a:status != 0
    call prettier#job#runner#onError(a:err)
    let s:prettier_job_running = 0
    return
  endif

  " we have no prettier output so lets exit
  if len(l:out) == 0 | return | endif

  " nothing to update
  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:info.start, a:info.end) == 0)
    let s:prettier_job_running = 0
    redraw!
    return
  endif

  " This is required due to race condition when user quickly switch buffers while the async
  " cli has not finished running, vim 8.0.1039 has introduced setbufline() which can be used
  " to fix this issue in a cleaner way, however since we still need to support older vim versions
  " we will apply a more generic solution
  if (l:isInsideAnotherBuffer)
    " Do no try to format buffers that have been closed
    if (bufloaded(a:info.buf_nr))
      try
        silent exec 'sp '. escape(bufname(a:info.buf_nr), ' \')
        call prettier#utils#buffer#replaceAndSave(l:out, a:info.start, a:info.end)
      catch
        call prettier#logging#error#log('PARSING_ERROR')
      finally
        " we should then hide this buffer again
        if a:info.buf_nr == bufnr('%')
          silent hide
        endif
      endtry
    endif
  else 
    call prettier#utils#buffer#replaceAndSave(l:out, a:info.start, a:info.end)
  endif
  let s:prettier_job_running = 0
endfunction
