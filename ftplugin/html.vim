" markdown/php files run this as well
" https://stackoverflow.com/questions/22839269/why-does-vim-default-markdown-ftplugin-source-html-ftplugins-is-there-any-ways
if expand('%:e') ==# 'html'
  let b:prettier_ft_default_args = {
    \ 'parser': 'html',
    \ }
endif
