function! prettier#job#async#neovim#run(cmd, startSelection, endSelection) abort
  let l:async_cmd = a:cmd

  if has('win32') || has('win64')
    let l:async_cmd = 'cmd.exe /c ' . a:cmd
  endif

  let l:lines = getline(a:startSelection, a:endSelection)
  let l:dict = {
        \ 'start': a:startSelection - 1,
        \ 'end': a:endSelection,
        \ 'buf_nr': bufnr('%'),
        \ 'content': join(l:lines, "\n"),
        \}
  let l:out = []
  let l:err = []

  let l:job = jobstart([&shell, &shellcmdflag, l:async_cmd], {
    \ 'on_stdout': {job_id, data, event -> extend(l:out, data)},
    \ 'on_stderr': {job_id, data, event -> extend(l:err, data)},
    \ 'on_exit': {job_id, status, event -> s:Prettier_Job_Nvim_Exit(status, l:dict, l:out, l:err)},
    \ })
  call jobsend(l:job, l:lines)
  call jobclose(l:job, 'stdin')
endfunction

function! s:Prettier_Job_Nvim_Exit(status, info, out, err) abort
  if a:status != 0
    echoerr join(a:err, "\n")
    return
  endif

  if len(a:out) == 0 | return | endif

  let l:last = a:out[len(a:out) - 1]
  let l:out = l:last ==? '' ? a:out[0:len(a:out) - 2] : a:out
  if a:info.content == join(l:out, "\n")
    " no change
    return
  endif

  call nvim_buf_set_lines(a:info.buf_nr, a:info.start, a:info.end, 0, l:out)
endfunction
