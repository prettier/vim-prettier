let b:prettier_ft_default_args = {
  \ 'parser': 'typescript',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.ts,*.tsx call prettier#Autoformat()
augroup end
