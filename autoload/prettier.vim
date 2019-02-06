" vim-prettier: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"
" Script Info  {{{
"==========================================================================================================
" Name Of File: prettier.vim
"  Description: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"   Maintainer: Mitermayer Reis <mitermayer.reis at gmail.com>
"      Version: 0.2.7
"        Usage: Use :help vim-prettier-usage, or visit https://github.com/prettier/vim-prettier
"
"==========================================================================================================
" }}}

let s:root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:prettier_job_running = 0
let s:prettier_quickfix_open = 0

function! prettier#PrettierCliPath() abort
  let l:execCmd = s:Get_Prettier_Exec()

  if l:execCmd != -1
    echom l:execCmd
  else
    call s:Suggest_Install_Prettier()
  endif
endfunction

function! prettier#PrettierCli(user_input) abort
  let l:execCmd = s:Get_Prettier_Exec()

  if l:execCmd != -1
    let l:out = system(l:execCmd. ' ' . a:user_input)
    echom l:out
  else
    call s:Suggest_Install_Prettier()
  endif
endfunction

function! prettier#Prettier(...) abort
  let l:execCmd = s:Get_Prettier_Exec()
  let l:async = a:0 > 0 ? a:1 : 0
  let l:startSelection = a:0 > 1 ? a:2 : 1
  let l:endSelection = a:0 > 2 ? a:3 : line('$')
  let l:config = getbufvar(bufnr('%'), 'prettier_ft_default_args', {})

  if l:execCmd != -1
    let l:cmd = l:execCmd . s:Get_Prettier_Exec_Args(l:config)

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
    call s:Suggest_Install_Prettier()
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

  if (s:Has_Content_Changed(l:out, a:startSelection, a:endSelection) == 0)
    return
  endif

  call s:Apply_Prettier_Format(l:out, a:startSelection, a:endSelection)
endfunction

function! s:Prettier_Exec_Async(cmd, startSelection, endSelection) abort
  let l:async_cmd = a:cmd

  if has('win32') || has('win64')
    let l:async_cmd = 'cmd.exe /c ' . a:cmd
  endif

  let l:bufferName = bufname('%')

  if s:prettier_job_running != 1
      let s:prettier_job_running = 1
      let l:job =  job_start([&shell, &shellcmdflag, l:async_cmd], {
        \ 'out_io': 'buffer',
        \ 'err_cb': {channel, msg -> s:Prettier_Job_Error(msg)},
        \ 'close_cb': {channel -> s:Prettier_Job_Close(channel, a:startSelection, a:endSelection, l:bufferName)}})
      let l:stdin = job_getchannel(l:job)
      call ch_sendraw(l:stdin, join(getbufline(bufnr(l:bufferName), a:startSelection,a:endSelection), "\n"))
      call ch_close_in(l:stdin)
    endif
endfunction

function! s:Prettier_Job_Close(channel, startSelection, endSelection, bufferName) abort
  let l:out = []
  let l:currentBufferName = bufname('%')
  let l:isInsideAnotherBuffer = a:bufferName != l:currentBufferName ? 1 : 0

  let l:buff = ch_getbufnr(a:channel, 'out')
  let l:out = getbufline(l:buff, 2, '$')
  execute 'bd!' . l:buff

  " nothing to update
  if (s:Has_Content_Changed(l:out, a:startSelection, a:endSelection) == 0)
    let s:prettier_job_running = 0
    redraw!
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
            echohl WarningMsg | echom 'Prettier: failed to parse buffer: ' . a:bufferName | echohl NONE
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
  call s:Apply_Prettier_Format(a:lines, a:start, a:end)
  write
endfunction

function! s:Prettier_Job_Error(msg) abort
    call s:Prettier_Parse_Error(split(a:msg, '\n'))
    let s:prettier_job_running = 0
endfunction

function! s:Handle_Parsing_Errors(out) abort
  let l:errors = []

  for l:line in a:out
    " matches:
    " file.ext: SyntaxError: Unexpected token (2:8)sd
    " stdin: SyntaxError: Unexpected token (2:8)
    " [error] file.ext: SyntaxError: Unexpected token (2:8)
    let l:match = matchlist(l:line, '^.*: \(.*\) (\(\d\{1,}\):\(\d\{1,}\)*)')
    if !empty(l:match)
      call add(l:errors, { 'bufnr': bufnr('%'),
                         \ 'text': l:match[1],
                         \ 'lnum': l:match[2],
                         \ 'col': l:match[3] })
    endif
  endfor

  if len(l:errors)
    let l:winnr = winnr()
    call setqflist(l:errors, 'r')
    botright copen
    if !g:prettier#quickfix_auto_focus
      " Return the cursor back to the main buffer.
      exe l:winnr . 'wincmd w'
    endif
    let s:prettier_quickfix_open = 1
  endif
endfunction

function! s:Has_Content_Changed(content, startLine, endLine) abort
  return getbufline(bufnr('%'), 1, line('$')) == s:Get_New_Buffer(a:content, a:startLine, a:endLine) ? 0 : 1
endfunction

function! s:Get_New_Buffer(lines, start, end) abort
  return getbufline(bufnr('%'), 1, a:start - 1) + a:lines + getbufline(bufnr('%'), a:end + 1, '$')
endfunction

function! s:Apply_Prettier_Format(lines, startSelection, endSelection) abort
  " store view
  let l:winview = winsaveview()
  let l:newBuffer = s:Get_New_Buffer(a:lines, a:startSelection, a:endSelection)

  " we should not replace contents if the newBuffer is empty
  if empty(l:newBuffer)
    return
  endif

  " delete all lines on the current buffer
  silent! execute '%delete _'

  " replace all lines from the current buffer with output from prettier
  let l:idx = 0
  for l:line in l:newBuffer
    silent! call append(l:idx, l:line)
    let l:idx += 1
  endfor
  
  " delete trailing newline introduced by the above append procedure
  silent! execute '$delete _'
  
  " Restore view
  call winrestview(l:winview)
endfunction

" By default we will default to our internal
" configuration settings for prettier
function! s:Get_Prettier_Exec_Args(config) abort
  " Allow params to be passed as json format
  " convert bellow usage of globals to a get function o the params defaulting to global
  let l:cmd = ' --print-width ' .
          \ get(a:config, 'printWidth', g:prettier#config#print_width) .
          \ ' --tab-width ' .
          \ get(a:config, 'tabWidth', g:prettier#config#tab_width) .
          \ ' --use-tabs ' .
          \ get(a:config, 'useTabs', g:prettier#config#use_tabs) .
          \ ' --semi ' .
          \ get(a:config, 'semi', g:prettier#config#semi) .
          \ ' --single-quote ' .
          \ get(a:config, 'singleQuote', g:prettier#config#single_quote) .
          \ ' --bracket-spacing ' .
          \ get(a:config, 'bracketSpacing', g:prettier#config#bracket_spacing) .
          \ ' --jsx-bracket-same-line ' .
          \ get(a:config, 'jsxBracketSameLine', g:prettier#config#jsx_bracket_same_line) .
          \ ' --arrow-parens ' .
          \ get(a:config, 'arrowParens', g:prettier#config#arrow_parens) .
          \ ' --trailing-comma ' .
          \ get(a:config, 'trailingComma', g:prettier#config#trailing_comma) .
          \ ' --parser ' .
          \ get(a:config, 'parser', g:prettier#config#parser) .
          \ ' --config-precedence ' .
          \ get(a:config, 'configPrecedence', g:prettier#config#config_precedence) .
          \ ' --prose-wrap ' .
          \ get(a:config, 'proseWrap', g:prettier#config#prose_wrap) .
          \ ' --html-whitespace-sensitivity ' .
          \ get(a:config, 'htmlWhitespaceSensitivity', g:prettier#config#html_whitespace_sensitivity) .
          \ ' --stdin-filepath "' .
          \ simplify(expand('%:p')) . '"' .
          \ ' --loglevel error '.
          \ ' --stdin '
  return l:cmd
endfunction

" By default we will search for the following
" => user defined prettier cli path from vim configuration file
" => locally installed prettier inside node_modules on any parent folder
" => globally installed prettier
" => vim-prettier prettier installation
" => if all fails suggest install
function! s:Get_Prettier_Exec() abort
  let l:user_defined_exec_path = fnamemodify(g:prettier#exec_cmd_path, ':p')
  if executable(l:user_defined_exec_path)
    return l:user_defined_exec_path
  endif

  let l:local_exec = s:Get_Prettier_Local_Exec()
  if executable(l:local_exec)
    return fnameescape(l:local_exec)
  endif

  let l:global_exec = s:Get_Prettier_Global_Exec()
  if executable(l:global_exec)
    return fnameescape(l:global_exec)
  endif

  let l:plugin_exec = s:Get_Prettier_Plugin_Exec()
  if executable(l:plugin_exec)
    return fnameescape(l:plugin_exec)
  endif

  return -1
endfunction

function! s:Get_Prettier_Local_Exec() abort
  return s:Get_Exec(getcwd())
endfunction

function! s:Get_Prettier_Global_Exec() abort
  return s:Get_Exec()
endfunction

function! s:Get_Prettier_Plugin_Exec() abort
  return s:Get_Exec(s:root_dir)
endfunction

function! s:Get_Exec(...) abort
  let l:rootDir = a:0 > 0 ? a:1 : 0
  let l:exec = -1

  if isdirectory(l:rootDir)
    let l:dir = s:Traverse_Dir_Search(l:rootDir)
    if l:dir != -1
      let l:exec = s:Get_Path_To_Exec(l:dir)
    endif
  else
    let l:exec = s:Get_Path_To_Exec()
  endif

  return l:exec
endfunction

function! s:Get_Path_To_Exec(...) abort
  let l:rootDir = a:0 > 0 ? a:1 : -1
  let l:dir = l:rootDir != -1 ? l:rootDir . '/.bin/' : ''
  return l:dir . 'prettier'
endfunction

function! s:Traverse_Dir_Search(rootDir) abort
  let l:root = a:rootDir
  let l:dir = 'node_modules'

  while 1
    let l:search_dir = l:root . '/' . l:dir
    if isdirectory(l:search_dir)
      return l:search_dir
    endif

    let l:parent = fnamemodify(l:root, ':h')
    if l:parent == l:root
      return -1
    endif

    let l:root = l:parent
  endwhile
endfunction

function! s:Prettier_Parse_Error(errors) abort
  echohl WarningMsg | echom 'Prettier: failed to parse buffer.' | echohl NONE
  if g:prettier#quickfix_enabled
    call s:Handle_Parsing_Errors(a:errors)
  endif
endfunction

" If we can't find any prettier installing we then suggest where to get it from
function! s:Suggest_Install_Prettier() abort
  echohl WarningMsg | echom 'Prettier: no prettier executable installation found.' | echohl NONE
endfunction
