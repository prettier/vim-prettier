" By default we will default to our internal
" configuration settings for prettier
function! prettier#resolver#config#resolve(config, hasSelection, start, end) abort
  " Allow params to be passed as json format
  " convert bellow usage of globals to a get function o the params defaulting to global
  " TODO: Use a list, filter() and join() to get a nicer list of args.
  let l:cmd = s:Flag_use_tabs(a:config) . ' ' .
          \ s:Flag_tab_width(a:config) . ' ' .
          \ s:Flag_print_width(a:config) . ' ' .
          \ s:Flag_parser(a:config) . ' ' .
          \ s:Flag_range_delimiter(a:config, a:hasSelection, a:start, a:end) . ' ' .
          \ ' --semi=' .
          \ get(a:config, 'semi', g:prettier#config#semi) .
          \ ' --single-quote=' .
          \ get(a:config, 'singleQuote', g:prettier#config#single_quote) .
          \ ' --bracket-spacing=' .
          \ get(a:config, 'bracketSpacing', g:prettier#config#bracket_spacing) .
          \ ' --jsx-bracket-same-line=' .
          \ get(a:config, 'jsxBracketSameLine', g:prettier#config#jsx_bracket_same_line) .
          \ ' --arrow-parens=' .
          \ get(a:config, 'arrowParens', g:prettier#config#arrow_parens) .
          \ ' --trailing-comma=' .
          \ get(a:config, 'trailingComma', g:prettier#config#trailing_comma) .
          \ ' --config-precedence=' .
          \ get(a:config, 'configPrecedence', g:prettier#config#config_precedence) .
          \ ' --prose-wrap=' .
          \ get(a:config, 'proseWrap', g:prettier#config#prose_wrap) .
          \ ' --html-whitespace-sensitivity ' .
          \ get(a:config, 'htmlWhitespaceSensitivity', g:prettier#config#html_whitespace_sensitivity) .
          \ ' --stdin-filepath="'.simplify(expand('%:p')).'"' .
          \ ' --require-pragma=' .
          \ get(a:config, 'requirePragma', g:prettier#config#require_pragma) .
          \ ' --end-of-line=' .
          \ get(a:config, 'endOfLine', g:prettier#config#end_of_line) .
          \ ' --loglevel error '.
          \ ' --stdin '

  return l:cmd
endfunction

" Returns either '--range-start X --range-end Y' or an empty string.
function! s:Flag_range_delimiter(config, partialFormatEnabled, start, end) abort
  if (!a:partialFormatEnabled)
    return ''
  endif

  let l:range = prettier#utils#buffer#getCharRange(a:start, a:end)

  return '--range-start=' . l:range[0] . ' --range-end=' . l:range[1]
endfunction

" Returns '--tab-width=NN'
function! s:Flag_tab_width(config) abort
  let l:value = get(a:config, 'tabWidth', g:prettier#config#tab_width)

  if (l:value ==# 'auto')
    let l:value = prettier#utils#shim#shiftwidth()
  endif

  return '--tab-width=' . l:value
endfunction

" Returns either '--use-tabs' or an empty string.
function! s:Flag_use_tabs(config) abort
  let l:value = get(a:config, 'useTabs', g:prettier#config#use_tabs)
  if (l:value ==# 'auto')
    let l:value = &expandtab ? 'false' : 'true'
  endif

  if ( l:value ==# 'true' )
    return ' --use-tabs'
  else
    return ''
  endif
endfunction

" Returns '--print-width=NN' or ''
function! s:Flag_print_width(config) abort
  let l:value = get(a:config, 'printWidth', g:prettier#config#print_width)

  if (l:value ==# 'auto')
    let l:value = &textwidth
  endif

  if (l:value > 0)
    return '--print-width=' . l:value
  else
    return ''
  endif
endfunction

" Returns '--parser=PARSER' or ''
function! s:Flag_parser(config) abort
  let l:value = get(a:config, 'parser', g:prettier#config#parser)

  if (l:value !=# '')
    return '--parser=' . l:value
  else
    return ''
  endif
endfunction
