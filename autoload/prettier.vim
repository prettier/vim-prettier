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

" Displays the resolve prettier CLI path
function! prettier#PrettierCliPath() abort
  let l:execCmd = prettier#resolver#executable#getPath()

  if l:execCmd != -1
    echom l:execCmd
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction

" Allows user commands to be passed straight to the prettier CLI
function! prettier#PrettierCli(user_input) abort
  let l:execCmd = prettier#resolver#executable#getPath()

  if l:execCmd != -1
    let l:out = system(l:execCmd. ' ' . a:user_input)
    echom l:out
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
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

" Main prettier command
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

    " format buffer
    call prettier#job#runner#run(l:cmd, l:startSelection, l:endSelection, l:async)
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction
