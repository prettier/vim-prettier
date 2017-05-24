if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

" => Plugin config
if !exists('g:prettier#autoformat') | let g:prettier#autoformat = 1 | endif

" => Prettier CLI config
" max line lengh that prettier will wrap on
if !exists('g:prettier#config#print_width') | let g:prettier#config#print_width = 80 | endif

" number of spaces per indentation level
if !exists('g:prettier#config#tab_width') | let g:prettier#config#tab_width = 2 | endif

" use tabs over spaces
if !exists('g:prettier#config#use_tabs') | let g:prettier#config#use_tabs = 0 | endif

" print semicolons
if !exists('g:prettier#config#semi') | let g:prettier#config#semi = 1 | endif

" single quotes over double quotes
if !exists('g:prettier#config#single_quote') | let g:prettier#config#single_quote = 1 | endif

" print spaces between brackets
if !exists('g:prettier#config#bracket_spacing') | let g:prettier#config#bracket_spacing = 0 | endif

" put > on the last line instead of new line
if !exists('g:prettier#config#jsx_bracket_same_line') | let g:prettier#config#jsx_bracket_same_line = 1 | endif

" none|es5|all
if !exists('g:prettier#config#trailing_comma') | let g:prettier#config#trailing_comma = 'all' | endif

" flow|babylon
if !exists('g:prettier#config#parser') | let g:prettier#config#parser = 'flow' | endif

command! Prettier call prettier#Prettier()

if !hasmapto('<Plug>(Prettier)') && maparg('<Leader>p', 'n') ==# ''
  nmap <unique> <Leader>p <Plug>(Prettier)
endif
nnoremap <silent> <Plug>(Prettier) :Prettier<CR>
