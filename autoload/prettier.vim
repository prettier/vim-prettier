" vim-prettier: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"
" Script Info  {{{
"==========================================================================================================
" Name Of File: prettier.vim
"  Description: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"   Maintainer: Mitermayer Reis <mitermayer.reis at gmail.com>
"      Version: 1.0.0-beta
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

" Allows @format and @prettier pragma support upon saving
function! prettier#Autoformat(...) abort
  let l:autoformat = g:prettier#autoformat_config_present ?
        \ prettier#IsConfigPresent(g:prettier#autoformat_config_files) :
        \ g:prettier#autoformat

  if l:autoformat
    call prettier#Prettier(1, 1, line('$'), 0, {
      \ 'requirePragma': g:prettier#autoformat_require_pragma ? 'true' : 'false'
      \ })
  endif
endfunction

" Main prettier command
function! prettier#Prettier(...) abort
  let l:execCmd = prettier#resolver#executable#getPath()
  let l:async = a:0 > 0 ? a:1 : 0
  let l:startSelection = a:0 > 1 ? a:2 : 1
  let l:endSelection = a:0 > 2 ? a:3 : line('$')
  let l:hasSelection = a:0 > 2 ? 1 : 0
  let l:partialFormat = a:0 > 3 && a:4 ? a:4 : 0
  let l:partialFormatEnabled = l:hasSelection && l:partialFormat

  let l:overWrite = a:0 > 4 ? a:5 : {}
  let l:bufferConfig = getbufvar(bufnr('%'), 'prettier_ft_default_args', {})
  let l:config = extend(l:bufferConfig, l:overWrite)

  if l:execCmd != -1
    " TODO
    " => we should make sure we can resolve --range-start  and --range-end when required
    "    => when the above is required we should also update l:startSelection to '1' and l:endSelection to line('$')
    let l:cmd = l:execCmd . prettier#resolver#config#resolve(
          \ prettier#resolver#preset#resolve(l:config),
          \ l:partialFormatEnabled,
          \ l:startSelection, 
          \ l:endSelection)

    " close quickfix if it is opened
    call prettier#utils#quickfix#close()

    " we will be using portion formatting, so we need to send entire buffer to prettier
    if l:partialFormatEnabled
      let l:startSelection = 1
      let l:endSelection = line('$')
    endif

    " format buffer
    call prettier#job#runner#run(l:cmd, l:startSelection, l:endSelection, l:async)
  else
    call prettier#logging#error#log('EXECUTABLE_NOT_FOUND_ERROR')
  endif
endfunction

" Set autoformat toggle based on whether config file was found.
function! prettier#IsConfigPresent(config_files) abort
  for config_file in a:config_files
    if filereadable(findfile(config_file, '.;'))
      return 1
    endif
  endfor
  return 0
endfunction
