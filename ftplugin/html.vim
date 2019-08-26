" markdown files run this as well
" https://stackoverflow.com/questions/22839269/why-does-vim-default-markdown-ftplugin-source-html-ftplugins-is-there-any-ways
if &ft !~# 'markdown'
  let b:prettier_ft_default_args = {
    \ 'parser': 'html',
    \ }
endif

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.html call prettier#Autoformat()
  endif
augroup end
