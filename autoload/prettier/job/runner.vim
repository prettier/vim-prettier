function! prettier#job#runner#run(cmd, startSelection, endSelection, async) abort
    if a:async && v:version >= 800 && exists('*job_start')
      "call s:Prettier_Exec_Async(l:cmd, l:startSelection, l:endSelection)
    elseif a:async && has('nvim') && g:prettier#nvim_unstable_async
      "call s:Prettier_Exec_Async_Nvim(l:cmd, l:startSelection, l:endSelection)
    else
      "call s:Prettier_Exec_Sync(l:cmd, l:startSelection, l:endSelection)
    endif
endfunction
