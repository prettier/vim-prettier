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

if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

" => Plugin config
" autoformating enabled by default upon saving
let g:prettier#autoformat = get(g:, 'prettier#autoformat', 1)

" experimental async flag will be disabled by default until is stable
let g:prettier#nvim_unstable_async = get(g:,'prettier#nvim_unstable_async', 0)

" path to prettier cli
let g:prettier#exec_cmd_path = get(g:, 'prettier#exec_cmd_path', 0)

" calling :Prettier by default runs synchronous
let g:prettier#exec_cmd_async = get(g:, 'prettier#exec_cmd_async', 0)

" when having formatting errors will open the quickfix by default
let g:prettier#quickfix_enabled = get(g:, 'prettier#quickfix_enabled', 1)

" => Prettier CLI config
" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = get(g:, 'prettier#config#print_width', 'auto')

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = get(g:,'prettier#config#tab_width', 'auto')

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = get(g:,'prettier#config#use_tabs', 'auto')

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = get(g:,'prettier#config#parser', '')

" cli-override|file-override|prefer-file
" default: 'prefer-file'
let g:prettier#config#config_precedence = get(g:, 'prettier#config#config_precedence', 'prefer-file')

" always|never|preserve
" default: 'preserve'
let g:prettier#config#prose_wrap = get(g:, 'prettier#config#prose_wrap', 'preserve')

" Don't leave the quicklist focused on error.
let g:prettier#quickfix_auto_focus = get(g:, 'prettier#quickfix_auto_focus', 1)

" synchronous by default
command! -nargs=? -range=% Prettier call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>)

" prettier async
command! -nargs=? -range=% PrettierAsync call prettier#Prettier(1, <line1>, <line2>)

" prints vim-prettier version
command! -nargs=? -range=% PrettierVersion echom '0.2.6'

" call prettier cli
command! -nargs=? -range=% PrettierCli call prettier#PrettierCli(<q-args>)

" call prettier cli to get its version
command! -nargs=? -range=% PrettierCliVersion call prettier#PrettierCli('--version')

" prints prettier resolved cli path
command! -nargs=? -range=% PrettierCliPath call prettier#PrettierCliPath()

" map command
if !hasmapto('<Plug>(Prettier)') && maparg('<Leader>p', 'n') ==# ''
  nmap <unique> <Leader>p <Plug>(Prettier)
endif
nnoremap <silent> <Plug>(Prettier) :Prettier<CR>
nnoremap <silent> <Plug>(PrettierAsync) :PrettierAsync<CR>
nnoremap <silent> <Plug>(PrettierVersion) :PrettierVersion<CR>
nnoremap <silent> <Plug>(PrettierCli) :PrettierCli<CR>
nnoremap <silent> <Plug>(PrettierCliVersion) :PrettierCliVersion<CR>
nnoremap <silent> <Plug>(PrettierCliPath) :PrettierCliPath<CR>
