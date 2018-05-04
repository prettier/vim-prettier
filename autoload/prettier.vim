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

let s:root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:prettier_job_running = 0
let s:prettier_quickfix_open = 0

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
    if s:prettier_quickfix_open
      call setqflist([], 'r')
      cclose
      let s:prettier_quickfix_open = 0
    endif

    if l:async && v:version >= 800 && exists('*job_start')
      call s:Prettier_Exec_Async(l:cmd, l:startSelection, l:endSelection)
    elseif l:async && has('nvim') && g:prettier#nvim_unstable_async
      call s:Prettier_Exec_Async_Nvim(l:cmd, l:startSelection, l:endSelection)
    else
      call s:Prettier_Exec_Sync(l:cmd, l:startSelection, l:endSelection)
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

function! s:Prettier_Exec_Sync(cmd, startSelection, endSelection) abort
  let l:bufferLinesList = getbufline(bufnr('%'), a:startSelection, a:endSelection)

  " vim 7 does not have support for passing a list to system()
  let l:bufferLines = v:version <= 800 ? join(l:bufferLinesList, "\n") : l:bufferLinesList

  let l:out = split(system(a:cmd, l:bufferLines), '\n')

  " check system exit code
  if v:shell_error
    call s:Prettier_Parse_Error(l:out)
    return
  endif

  if (prettier#utils#buffer#willUpdatedLinesChangeBuffer(l:out, a:startSelection, a:endSelection) == 0)
    return
  endif

  call prettier#utils#buffer#replace(l:out, a:startSelection, a:endSelection)
endfunction

function! s:Prettier_Exec_Async(cmd, startSelection, endSelection) abort
  let l:async_cmd = a:cmd

  if has('win32') || has('win64')
    let l:async_cmd = 'cmd.exe /c ' . a:cmd
  endif

  let l:bufferName = bufname('%')

  if s:prettier_job_running != 1
      let s:prettier_job_running = 1
      call job_start([&shell, &shellcmdflag, l:async_cmd], {
        \ 'in_io': 'buffer',
        \ 'in_top': a:startSelection,
        \ 'in_bot': a:endSelection,
        \ 'in_name': l:bufferName,
        \ 'err_cb': {channel, msg -> s:Prettier_Job_Error(msg)},
        \ 'close_cb': {channel -> s:Prettier_Job_Close(channel, a:startSelection, a:endSelection, l:bufferName)}})
  endif
endfunction

function! s:Prettier_Job_Close(channel, startSelection, endSelection, bufferName) abort
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
            call s:Prettier_Format_And_Save(l:out, a:startSelection, a:endSelection)
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
        call s:Prettier_Format_And_Save(l:out, a:startSelection, a:endSelection)
      endif

      let s:prettier_job_running = 0
  endif
endfunction

function! s:Prettier_Format_And_Save(lines, start, end) abort
  call prettier#utils#buffer#replace(a:lines, a:start, a:end)
  write
endfunction

function! s:Prettier_Job_Error(msg) abort
    call s:Prettier_Parse_Error(split(a:msg, '\n'))
    let s:prettier_job_running = 0
endfunction

function! s:Prettier_Parse_Error(errors) abort
  call prettier#logging#error#log('PARSING_ERROR')
  if g:prettier#quickfix_enabled && prettier#bridge#parser#onError(a:errors)
    let s:prettier_quickfix_open = 1
  endif
endfunction
