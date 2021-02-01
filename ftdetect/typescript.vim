augroup PrettierFileDetect
  autocmd BufNewFile,BufReadPost *.ts setfiletype typescript
  autocmd BufNewFile,BufReadPost *.tsx setfiletype typescriptreact
augroup end
