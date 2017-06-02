if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

" => Plugin config
let g:prettier#autoformat = get(g:, 'g:prettier#autoformat', 1)

" => Prettier CLI config
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = get(g:, 'g:prettier#config#print_width', 80)

" number of spaces per indentation level
let g:prettier#config#tab_width = get(g:,'g:prettier#config#tab_width', 2)

" use tabs over spaces
let g:prettier#config#use_tabs = get(g:,'g:prettier#config#use_tabs', 'false')

" print semicolons
let g:prettier#config#semi = get(g:,'g:prettier#config#semi', 'true')

" single quotes over double quotes
let g:prettier#config#single_quote = get(g:,'g:prettier#config#single_quote', 'true')

" print spaces between brackets
let g:prettier#config#bracket_spacing = get(g:,'g:prettier#config#bracket_spacing', 'false')

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = get(g:,'g:prettier#config#jsx_bracket_same_line', 'true')

" none|es5|all
let g:prettier#config#trailing_comma = get(g:,'g:prettier#config#trailing_comma', 'all')

" flow|babylon
let g:prettier#config#parser = get(g:,'g:prettier#config#parser', 'flow')

command! Prettier call prettier#Prettier()

if !hasmapto('<Plug>(Prettier)') && maparg('<Leader>p', 'n') ==# ''
  nmap <unique> <Leader>p <Plug>(Prettier)
endif
nnoremap <silent> <Plug>(Prettier) :Prettier<CR>
