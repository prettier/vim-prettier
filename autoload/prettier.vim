let s:root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! prettier#Prettier() abort
  let l:exec = s:Get_Prettier_Exec()

  if &ft !~ 'javascript'
    return 
  endif

  if exec != -1
    let l:stdout = split(system(exec . s:Get_Prettier_Exec_Args(), getbufline(bufnr('%'), 1, '$')), '\n')

    " check system exit code
    if v:shell_error
      echohl WarningMsg | echom 'Prettier: failed to parse buffer.' | echohl NONE
      return
    endif

    " delete all lines on the current buffer
    silent! execute 1 . ',' . line('$') . 'delete _'

    " replace all lines from the current buffer with output from prettier
    call setline(1, stdout)
  else
    call s:Suggest_Install_Prettier()
  endif
endfunction

function! prettier#Autoformat() abort
  let l:curPos = getpos('.')
  let l:maxLineLookup = 50 
  let l:maxTimeLookupMs = 500 
  let l:pattern = '@format'

  " we need to move selection to the top before looking up to avoid 
  " scanning a very long file
  call cursor(1, 1)

  " Search starting at the start of the document
  if search(pattern, 'n', maxLineLookup, maxTimeLookupMs) > 0
    call prettier#Prettier()
  endif

  " Restore the selection and if greater then before it defaults to end
  call cursor(curPos[1], curPos[2])
endfunction

" By default we will default to our internal
" configuration settings for prettier
function! s:Get_Prettier_Exec_Args() abort
  let l:cmd = ' --print-width ' .
          \ g:prettier#config#print_width .
          \ ' --tab-width ' .
          \ g:prettier#config#tab_width .
          \ ' --use-tabs ' .
          \ g:prettier#config#use_tabs .
          \ ' --semi ' .
          \ g:prettier#config#semi .
          \ ' --single-quote ' .
          \ g:prettier#config#single_quote .
          \ ' --bracket-spacing ' .
          \ g:prettier#config#bracket_spacing .
          \ ' --jsx-bracket-same-line ' .
          \ g:prettier#config#jsx_bracket_same_line .
          \ ' --trailing-comma ' .
          \ g:prettier#config#trailing_comma .
          \ ' --parser ' .
          \ g:prettier#config#parser .
          \ ' --stdin '
  return cmd
endfunction

" By default we will search for the following
" => locally installed prettier inside node_modules on any parent folder
" => globally installed prettier 
" => vim-prettier prettier installation
" => if all fails suggest install
function! s:Get_Prettier_Exec() abort
  let l:local_exec = s:Get_Prettier_Local_Exec()
  if local_exec != -1
    return local_exec
  endif 

  let l:global_exec = s:Get_Prettier_Global_Exec()
  global_exec != -1
    return global_exec
  endif 

  let l:plugin_exec = s:Get_Prettier_Plugin_Exec()
  if plugin_exec != -1
    return plugin_exec
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
  let l:exec = 0

  if rootDir
    let l:dir = s:Tranverse_Dir_Search(rootDir) 
    if dir != -1
      let l:exec = s:Get_Path_To_Exec(dir)
    endif
  else
    let l:exec = s:Get_Path_To_Exec()
  endif

  if executable(exec)
    return exec
  endif

  return -1 
endfunction

function! s:Get_Path_To_Exec(...) abort
  let l:rootDir = a:0 > 0 ? a:1 : -1 
  let l:dir = rootDir != -1 ? rootDir . '/.bin/' : '' 
  return dir . 'prettier'
endfunction

function! s:Tranverse_Dir_Search(rootDir) abort
  let l:root = a:rootDir
  let l:dir = 'node_modules'

  while 1
    let l:search_dir = root . '/' . dir
    if isdirectory(search_dir) 
      return search_dir
    endif

    let l:parent = fnamemodify(root, ':h')
    if parent == root 
      return -1
    endif

    let l:root = parent
  endwhile
endfunction

" If we can't find any prettier installing we then suggest where to get it from
function! s:Suggest_Install_Prettier() abort
  echohl WarningMsg | echom 'Prettier: no prettier executable installation found.' | echohl NONE
endfunction
