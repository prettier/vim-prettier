let s:prettier_job_running = 0

function! prettier#job#async#vim#run(cmd, startSelection, endSelection) abort
  let l:cmd = a:cmd

  if has('win32') || has('win64')
    let l:cmd = 'cmd.exe /c ' . a:cmd
  endif

  let l:bufferName = bufname('%')

  if s:prettier_job_running != 1
      let s:prettier_job_running = 1
      call job_start([&shell, &shellcmdflag, l:cmd], {
        \ 'in_io': 'buffer',
        \ 'in_top': a:startSelection,
        \ 'in_bot': a:endSelection,
        \ 'in_name': l:bufferName,
        \ 'err_cb': {channel, msg -> s:onError(msg)},
        \ 'close_cb': {channel -> s:onClose(channel, a:startSelection, a:endSelection, l:bufferName)}})
  endif
endfunction

function! s:onError(msg) abort
    call prettier#job#runner#onError(split(a:msg, '\n'))
    let s:prettier_job_running = 0
endfunction

function! s:onClose(channel, startSelection, endSelection, bufferName) abort
  let l:out = []
  let l:currentBufferName = bufname('%')
  let l:isInsideAnotherBuffer = a:bufferName != l:currentBufferName ? 1 : 0

  while ch_status(a:channel) ==# 'buffered'
    call add(l:out, ch_read(a:channel))
  endwhile

  " nothing to update
  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:startSelection, a:endSelection) == 0)
    let s:prettier_job_running = 0
    return
  endif

  if len(l:out)
      " This is required due to race condition when user quickly switch buffers while the async
      " cli has not finished running, vim 8.0.1039 has introduced setbufline() which can be used
      " to fix this issue in a cleaner way, however since we still need to support older vim versions
      " we will apply a more generic solution
      if (l:isInsideAnotherBuffer)
        if (bufloaded(str2nr(a:bufferName)))
          try
            silent exec 'sp '. escape(bufname(bufnr(a:bufferName)), ' \')
            call s:formatAndSave(l:out, a:startSelection, a:endSelection)
          catch
            call prettier#logging#error#log('PARSING_ERROR', a:bufferName)
          finally
            " we should then hide this buffer again
            if a:bufferName == bufname('%')
              silent hide
            endif
          endtry
        endif
      else
        call s:formatAndSave(l:out, a:startSelection, a:endSelection)
      endif

      let s:prettier_job_running = 0
  endif
endfunction

" TODO
" make the buffer replace method accerpt an extra arg to 
" decide if it should save it or not and delete this method
function! s:formatAndSave(lines, start, end) abort
  call prettier#utils#buffer#replace(a:lines, a:start, a:end)
  write
endfunction
