" TODO
" move the bellow vim checks to UTILS
let s:isLegacyVim = v:version < 800
let s:isNeoVim = has('nvim')
let s:isAsyncVim = !s:isLegacyVim && exists('*job_start')

function! prettier#job#runner#run(cmd, startSelection, endSelection, async) abort
    if a:async && (s:isAsyncVim || s:isNeoVim)
      call s:asyncFormat(a:cmd, a:startSelection, a:endSelection)
    else
      call s:format(a:cmd, a:startSelection, a:endSelection)
    endif
endfunction

function! prettier#job#runner#onError(errors) abort
  call prettier#logging#error#log('PARSING_ERROR')
  if g:prettier#quickfix_enabled
    call prettier#bridge#parser#onError(a:errors, g:prettier#quickfix_auto_focus)
  endif
endfunction

function! s:asyncFormat(cmd, startSelection, endSelection) abort
    if !s:isAsyncVim && !s:isNeoVim 
      call s:format(a:cmd, a:startSelection, a:endSelection)
    endif 

    " required for Windows support on async operations 
    let l:cmd = a:cmd
    if has('win32') || has('win64')
      let l:cmd = 'cmd.exe /c ' . a:cmd
    endif

    if s:isAsyncVim
      call prettier#job#async#vim#run(l:cmd, a:startSelection, a:endSelection)
    else
      call prettier#job#async#neovim#run(l:cmd, a:startSelection, a:endSelection)
    endif
endfunction

function! s:format(cmd, startSelection, endSelection) abort
  let l:bufferLinesList = getbufline(bufnr('%'), a:startSelection, a:endSelection)

  " vim 7 does not have support for passing a list to system()
  let l:bufferLines = s:isLegacyVim ? join(l:bufferLinesList, "\n") : l:bufferLinesList

  " TODO
  " since we are using two different types for system, maybe we should move it to utils shims
  let l:out = split(system(a:cmd, l:bufferLines), '\n')

  " check system exit code
  if v:shell_error
    call prettier#job#runner#onError(l:out)
    return
  endif

  " TODO
  " doing 0 checks seems weird can we do this bellow differently ?
  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:startSelection, a:endSelection) == 0)
    return
  endif

  call prettier#utils#buffer#replace(l:out, a:startSelection, a:endSelection)
endfunction
