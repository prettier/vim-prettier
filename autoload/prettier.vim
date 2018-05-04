" vim-prettier: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"
" Script Info  {{{
"==========================================================================================================
" Name Of File: prettier.vim
"  Description: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"   Maintainer: Mitermayer Reis <mitermayer.reis at gmail.com>
"      Version: 0.2.6
"        Usage: Use :help vim-prettier-usage, or visit https://github.com/prettier/vim-prettier
"
"==========================================================================================================
" }}}

let s:prettier_job_running = 0

function! prettier#PrettierCliPath() abort
  let l:execCmd = prettier#resolver#executable#getPath()

  if l:execCmd != -1
    echom l:execCmd
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction

function! prettier#PrettierCli(user_input) abort
  let l:execCmd = prettier#resolver#executable#getPath()

  if l:execCmd != -1
    let l:out = system(l:execCmd. ' ' . a:user_input)
    echom l:out
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction

function! prettier#Prettier(...) abort
  let l:execCmd = prettier#resolver#executable#getPath()
  let l:async = a:0 > 0 ? a:1 : 0
  let l:startSelection = a:0 > 1 ? a:2 : 1
  let l:endSelection = a:0 > 2 ? a:3 : line('$')
  let l:config = getbufvar(bufnr('%'), 'prettier_ft_default_args', {})

  if l:execCmd != -1
    let l:cmd = l:execCmd . prettier#resolver#config#buildCliArgs(l:config)

    " close quickfix if it is opened
    call prettier#utils#quickfix#close()

    if l:async && has('nvim') && g:prettier#nvim_unstable_async
      call s:Prettier_Exec_Async_Nvim(l:cmd, l:startSelection, l:endSelection)
    else
      call prettier#job#runner#run(l:cmd, l:startSelection, l:endSelection, l:async)
    endif
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction

function! s:Prettier_Exec_Async_Nvim(cmd, startSelection, endSelection) abort
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

function! prettier#Autoformat(...) abort
  let l:curPos = getpos('.')
  let l:maxLineLookup = 50
  let l:maxTimeLookupMs = 500
  let l:pattern = '@format'
  let l:search = @/
  let l:winview = winsaveview()

  " we need to move selection to the top before looking up to avoid
  " scanning a very long file
  call cursor(1, 1)

  " Search starting at the start of the document
  if search(l:pattern, 'n', l:maxLineLookup, l:maxTimeLookupMs) > 0
    " autoformat async
    call prettier#Prettier(1)
  endif

  " Restore the selection and if greater then before it defaults to end
  call cursor(l:curPos[1], l:curPos[2])

  " Restore view
  call winrestview(l:winview)

  " Restore search
  let @/=l:search
endfunction
