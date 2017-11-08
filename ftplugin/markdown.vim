augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.markdown,*.md,*.mdown,*.mkd,*.mkdn call prettier#Autoformat()
  endif
augroup end
