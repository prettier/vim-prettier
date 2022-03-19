let s:ROOT_DIR = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" By default we will search for the following
" => user defined prettier cli path from vim configuration file
" => locally installed prettier inside node_modules on any parent folder
" => globally installed prettier
" => vim-prettier prettier installation
" => if all fails suggest install
function! prettier#resolver#executable#getPath() abort
  let l:user_defined_exec_path = fnamemodify(g:prettier#exec_cmd_path, ':p')
  if executable(l:user_defined_exec_path)
    return l:user_defined_exec_path
  endif

  let l:localExec = s:ResolveExecutable(getcwd())
  if executable(l:localExec)
    return fnameescape(l:localExec)
  endif

  let l:globalExec = s:ResolveExecutable()
  if executable(l:globalExec)
    return fnameescape(l:globalExec)
  endif

  let l:pluginExec = s:ResolveExecutable(s:ROOT_DIR)
  if executable(l:pluginExec)
    return fnameescape(l:pluginExec)
  endif

  return -1
endfunction

function! s:GetExecPath(...) abort
  let l:rootDir = a:0 > 0 ? a:1 : -1
  let l:dir = l:rootDir != -1 ? l:rootDir . '/.bin/' : ''
  let l:path = l:dir . get(b:, 'prettier_exec_cmd', 'prettier')
  if executable(l:path)
    return l:path
  else
    return l:dir . 'prettier'
  endif
endfunction

" Searches for the existence of a directory accross 
" ancestral parents
function! s:TraverseAncestorDirSearch(rootDir) abort
  let l:root = a:rootDir
  let l:dir = 'node_modules'

  while 1
    let l:searchDir = l:root . '/' . l:dir
    if isdirectory(l:searchDir)
      if executable(s:GetExecPath(l:searchDir))
        return l:searchDir
      endif
    endif

    let l:parent = fnamemodify(l:root, ':h')
    if l:parent == l:root
      return -1
    endif

    let l:root = l:parent
  endwhile
endfunction

function! s:ResolveExecutable(...) abort
  let l:rootDir = a:0 > 0 ? a:1 : 0
  let l:exec = "."

  if isdirectory(l:rootDir)
    let l:dir = s:TraverseAncestorDirSearch(l:rootDir)
    if l:dir != -1
      let l:exec = s:GetExecPath(l:dir)
    endif
  else
    let l:exec = s:GetExecPath()
  endif

  return l:exec
endfunction
