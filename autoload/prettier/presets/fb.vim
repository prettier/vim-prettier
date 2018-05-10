" Return facebook style config overwrite presets
function! prettier#presets#fb#config() abort
  return { 
  \ 'bracketSpacing': 'false',
  \ 'jsxBracketSameLine': 'true',
  \ 'printWidth': 80,
  \ 'parser': 'flow',
  \ 'singleQuote': 'true',
  \ 'tabWidth': 2,
  \ 'trailingComma': 'all',
  \ 'useTabs': 'false',
  \ }
endfunction
