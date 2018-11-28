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
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = get(g:, 'prettier#config#print_width', 80)

" number of spaces per indentation level
let g:prettier#config#tab_width = get(g:,'prettier#config#tab_width', 2)

" use tabs over spaces
let g:prettier#config#use_tabs = get(g:,'prettier#config#use_tabs', 'false')

" print semicolons
let g:prettier#config#semi = get(g:,'prettier#config#semi', 'true')

" single quotes over double quotes
let g:prettier#config#single_quote = get(g:,'prettier#config#single_quote', 'true')

" print spaces between brackets
let g:prettier#config#bracket_spacing = get(g:,'prettier#config#bracket_spacing', 'false')

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = get(g:,'prettier#config#jsx_bracket_same_line', 'true')

" avoid wrapping a single arrow function param in parens
let g:prettier#config#arrow_parens = get(g:,'prettier#config#arrow_parens', 'avoid')

" none|es5|all
let g:prettier#config#trailing_comma = get(g:,'prettier#config#trailing_comma', 'all')

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = get(g:,'prettier#config#parser', 'flow')

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = get(g:, 'prettier#config#config_precedence', 'prefer-file')

" always|never|preserve
let g:prettier#config#prose_wrap = get(g:, 'prettier#config#prose_wrap', 'preserve')

" css|strict|ignore
let g:prettier#config#html_whitespace_sensitivity = get(g:, 'prettier#config#html_whitespace_sensitivity', 'css')

" Don't leave the quicklist focused on error.
let g:prettier#quickfix_auto_focus = get(g:, 'prettier#quickfix_auto_focus', 1)

" synchronous by default
command! -nargs=? -range=% Prettier call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>)

" prettier async
command! -nargs=? -range=% PrettierAsync call prettier#Prettier(1, <line1>, <line2>)

" prints vim-prettier version
command! -nargs=? -range=% PrettierVersion echom '0.2.7'

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
