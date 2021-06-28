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

if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

" => Plugin config
" autoformating disabled by default upon saving
let g:prettier#autoformat = get(g:, 'prettier#autoformat', 0)

" autoformating requires pragma by default
let g:prettier#autoformat_require_pragma = get(g:, 'prettier#autoformat_require_pragma', 1)

" whether to turn autoformatting on if a prettier config file is found
let g:prettier#autoformat_config_present = get(g:, 'prettier#autoformat_config_present', 0)

" prettier config files to search current directory and parent directories for
let g:prettier#autoformat_config_files = get(g:, 'prettier#autoformat_config_files', [
      \'.prettierrc',
      \'.prettierrc.yml',
      \'.prettierrc.yaml',
      \'.prettierrc.js',
      \'.prettierrc.config.js',
      \'.prettierrc.json',
      \'.prettierrc.toml'])

" path to prettier cli
let g:prettier#exec_cmd_path = get(g:, 'prettier#exec_cmd_path', 0)

" calling :Prettier by default runs synchronous
let g:prettier#exec_cmd_async = get(g:, 'prettier#exec_cmd_async', 0)

" when having formatting errors will open the quickfix by default
let g:prettier#quickfix_enabled = get(g:, 'prettier#quickfix_enabled', 1)

" Don't leave the quicklist focused on error.
let g:prettier#quickfix_auto_focus = get(g:, 'prettier#quickfix_auto_focus', 1)

" Send to prettier entire buffer and use --range-start and --range-end as delimter
let g:prettier#partial_format = get(g:, 'prettier#partial_format', 0)

" default|fb
" Use prettier defaults
let g:prettier#preset#config = get(g:,'prettier#preset#config', 'default')

" => Prettier CLI config
" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
" See more: https://prettier.io/docs/en/options.html#print-width
let g:prettier#config#print_width = get(g:, 'prettier#config#print_width', 'auto')

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
" See more: https://prettier.io/docs/en/options.html#tab-width
let g:prettier#config#tab_width = get(g:,'prettier#config#tab_width', 'auto')

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
" See more: https://prettier.io/docs/en/options.html#tabs
let g:prettier#config#use_tabs = get(g:,'prettier#config#use_tabs', 'auto')

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
" See more: https://prettier.io/docs/en/options.html#parser
let g:prettier#config#parser = get(g:,'prettier#config#parser', '')

" cli-override|file-override|prefer-file
" default: 'file-override'
" See more: https://prettier.io/docs/en/cli.html#--config-precedence
let g:prettier#config#config_precedence = get(g:, 'prettier#config#config_precedence', 'file-override')

" always|never|preserve
" default: 'preserve'
" See more: https://prettier.io/docs/en/options.html#prose-wrap
let g:prettier#config#prose_wrap = get(g:, 'prettier#config#prose_wrap', 'preserve')

" css|strict|ignore
" default: 'css'
" See more: https://prettier.io/docs/en/options.html#html-whitespace-sensitivity
let g:prettier#config#html_whitespace_sensitivity = get(g:, 'prettier#config#html_whitespace_sensitivity', 'css')

" print semicolons
" default: 'true'
" See more: https://prettier.io/docs/en/options.html#semicolons
let g:prettier#config#semi = get(g:,'prettier#config#semi', 'true')

" Use single quotes instead of double quotes.
" default: 'false'
" See more: https://prettier.io/docs/en/options.html#quotes
let g:prettier#config#single_quote = get(g:,'prettier#config#single_quote', 'false')

" print spaces between brackets
" default: 'true'
" See more: https://prettier.io/docs/en/options.html#bracket-spacing
let g:prettier#config#bracket_spacing = get(g:,'prettier#config#bracket_spacing', 'true')

" put > on the last line instead of new line
" default: 'false'
" See more: https://prettier.io/docs/en/options.html#jsx-brackets
let g:prettier#config#jsx_bracket_same_line = get(g:,'prettier#config#jsx_bracket_same_line', 'false')

" avoid wrapping a single arrow function param in parens
" avoid|always
" default: 'always'
" See more: https://prettier.io/docs/en/options.html#arrow-function-parentheses
let g:prettier#config#arrow_parens = get(g:,'prettier#config#arrow_parens', 'always')

" Define the flavor of line endings
" lf|crlf|cr|all
" defaut: 'lf' 
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')

" Print trailing commas wherever possible when multi-line.
" none|es5|all
" default: 'es5'
" See more: https://prettier.io/docs/en/options.html#trailing-commas
let g:prettier#config#trailing_comma = get(g:,'prettier#config#trailing_comma', 'es5')

" restrict itself to only format files that contain a special comment @prettier or @format
" See more: https://prettier.io/docs/en/options.html#require-pragma
let g:prettier#config#require_pragma=  get(g:, 'prettier#config#require_pragma', 'false')

" synchronous by default
command! -nargs=? -range=% Prettier call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>, g:prettier#partial_format)

" prettier async
command! -nargs=? -range=% PrettierAsync call prettier#Prettier(1, <line1>, <line2>, g:prettier#partial_format)

" prints vim-prettier version
command! -nargs=? -range=% PrettierVersion echom '1.0.0-beta'

" call prettier cli
command! -nargs=? -range=% PrettierCli call prettier#PrettierCli(<q-args>)

" call prettier cli to get its version
command! -nargs=? -range=% PrettierCliVersion call prettier#PrettierCli('--version')

" prints prettier resolved cli path
command! -nargs=? -range=% PrettierCliPath call prettier#PrettierCliPath()

" sends selected text to prettier cli for formatting
command! -nargs=? -range=% PrettierFragment call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>, 0)

" sends entire buffer to prettier cli but format just selection 
command! -nargs=? -range=% PrettierPartial call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>, 1)

" map command
if !hasmapto('<Plug>(Prettier)') && maparg('<Leader>p', 'n') ==# ''
  nmap <unique> <Leader>p <Plug>(Prettier)
endif
nnoremap <silent> <Plug>(Prettier) :Prettier<CR>
nnoremap <silent> <Plug>(PrettierAsync) :PrettierAsync<CR>
nnoremap <silent> <Plug>(PrettierFragment) :PrettierFragment<CR>
nnoremap <silent> <Plug>(PrettierPartial) :PrettierPartial<CR>
nnoremap <silent> <Plug>(PrettierVersion) :PrettierVersion<CR>
nnoremap <silent> <Plug>(PrettierCli) :PrettierCli<CR>
nnoremap <silent> <Plug>(PrettierCliVersion) :PrettierCliVersion<CR>
nnoremap <silent> <Plug>(PrettierCliPath) :PrettierCliPath<CR>

augroup Prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.markdown,*.md,*.mdown,*.mkd,*.mkdn,*.mdx,*.vue,*.svelte,*.yml,*.yaml,*.html,*.php,*.rb,*.ruby,*.xml noautocmd call prettier#Autoformat()
augroup end
