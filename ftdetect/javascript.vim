augroup PrettierFileDetect
  autocmd BufNewFile,BufReadPost *.js,*jsx setfiletype javascript
  autocmd BufRead,BufNewFile * if getline(1) =~ '#!/.*\<\(bun\|deno\|node\|zx\)\>' | setfiletype javascript | endif
augroup end
