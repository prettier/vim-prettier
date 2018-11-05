let s:prettier_job_running = 0

function! prettier#job#async#vim#run(cmd, startSelection, endSelection) abort
  if s:prettier_job_running == 1
    return
  endif 
  let s:prettier_job_running = 1

  let l:bufferName = bufname('%')

  let l:job = job_start([&shell, &shellcmdflag, a:cmd], {
    \ 'out_io': 'buffer',
    \ 'err_cb': {channel, msg -> s:onError(msg)},
    \ 'close_cb': {channel -> s:onClose(channel, a:startSelection, a:endSelection, l:bufferName)}})

  let l:stdin = job_getchannel(l:job)

  call ch_sendraw(l:stdin, join(getbufline(bufnr(l:bufferName), a:startSelection, a:endSelection), "\n"))
  call ch_close_in(l:stdin)
endfunction

function! s:onError(msg) abort
    call prettier#job#runner#onError(split(a:msg, '\n'))
    let s:prettier_job_running = 0
endfunction

function! s:onClose(channel, startSelection, endSelection, bufferName) abort
  let l:out = []
  let l:currentBufferName = bufname('%')
  let l:isInsideAnotherBuffer = a:bufferName != l:currentBufferName ? 1 : 0

  let l:buff = ch_getbufnr(a:channel, 'out')
  let l:out = getbufline(l:buff, 2, '$')
  execute 'bd!' . l:buff

  " we have no prettier output so lets exit
  if len(l:out) == 0 | return | endif

  " nothing to update
  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:startSelection, a:endSelection) == 0)
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
    if (bufloaded(str2nr(a:bufferName)))
      try
        silent exec 'sp '. escape(bufname(bufnr(a:bufferName)), ' \')
        call prettier#utils#buffer#replaceAndSave(l:out, a:startSelection, a:endSelection)
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
    call prettier#utils#buffer#replaceAndSave(l:out, a:startSelection, a:endSelection)
  endif
  let s:prettier_job_running = 0
endfunction
