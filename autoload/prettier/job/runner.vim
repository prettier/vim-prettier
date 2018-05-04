" TODO
" move the bellow vim checks to UTILS
"
" TODO 
" we are currently feature protecting async on NVIM with g:prettier#nvim_unstable_async
" we should remove this once its fully supported
let s:isNeoVim = has('nvim') && g:prettier#nvim_unstable_async
let s:isAsyncVim = v:version >= 800 && exists('*job_start')
let s:isLegacyVim = v:version <= 800

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

function! s:asyncFormat(cmd, startSelection, endSelection, autoFocus) abort
    if s:isAsyncVim
      echom 'async vim'
    else
      echom 'neovim'
    endif
endfunction

function! s:format(cmd, startSelection, endSelection) abort
  let l:bufferLinesList = getbufline(bufnr('%'), a:startSelection, a:endSelection)

  " vim 7 does not have support for passing a list to system()
  let l:bufferLines = s:isLegacyVim ? join(l:bufferLinesList, "\n") : l:bufferLinesList

  let l:out = split(system(a:cmd, l:bufferLines), '\n')

  " check system exit code
  if v:shell_error
    call prettier#job#runner#onError(l:out)
    return
  endif

  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:startSelection, a:endSelection) == 0)
    return
  endif

  call prettier#utils#buffer#replace(l:out, a:startSelection, a:endSelection)
endfunction
