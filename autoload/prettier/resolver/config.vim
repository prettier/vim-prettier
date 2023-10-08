" By default we will default to our internal
" configuration settings for prettier
function! prettier#resolver#config#resolve(config, hasSelection, start, end) abort
  " Allow params to be passed as json format
  " convert bellow usage of globals to a get function o the params defaulting to global
  " TODO: Use a list, filter() and join() to get a nicer list of args.
  let l:config_and_sel = {
          \ 'config': a:config,
          \ 'hasSelection': a:hasSelection,
          \ 'start': a:start,
          \ 'end': a:end}

  let l:cmd = s:Flag_use_tabs(l:config_and_sel, '--use-tabs', {}) . ' ' .
          \ s:Flag_tab_width(l:config_and_sel, '--tab-width', {}) . ' ' .
          \ s:Flag_print_width(l:config_and_sel, '--print-width', {}) . ' ' .
          \ s:Flag_parser(l:config_and_sel, '--parser', {}) . ' ' .
          \ s:Flag_range_start(l:config_and_sel, '', {}) . ' ' .
          \ s:Flag_range_end(l:config_and_sel, '', {}) . ' ' .
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
          \ ' ' . s:Flag_stdin_filepath(l:config_and_sel, '--stdin-filepath', {}) .
          \ ' --require-pragma=' .
          \ get(a:config, 'requirePragma', g:prettier#config#require_pragma) .
          \ ' --end-of-line=' .
          \ get(a:config, 'endOfLine', g:prettier#config#end_of_line) .
          \ ' ' . s:Flag_loglevel(l:config_and_sel, '--loglevel', {}) .
          \ ' ' . s:Flag_stdin(l:config_and_sel, '--stdin', {})

  return l:cmd
endfunction

" Returns either '--range-start X' or an empty string.
function! s:Flag_range_start(config_and_sel, ...) abort
  if (!a:config_and_sel.hasSelection)
    return ''
  endif

  let l:rangeStart =
          \ prettier#utils#buffer#getCharRangeStart(a:config_and_sel.start)

  return '--range-start=' . l:rangeStart
endfunction

" Returns either '--range-end Y' or an empty string.
function! s:Flag_range_end(config_and_sel, ...) abort
  if (!a:config_and_sel.hasSelection)
    return ''
  endif

  let l:rangeEnd =
          \ prettier#utils#buffer#getCharRangeEnd(a:config_and_sel.end)

  return '--range-end=' . l:rangeEnd
endfunction

" Returns '--tab-width=NN'
function! s:Flag_tab_width(config_and_sel, ...) abort
  let l:value = get(
          \ a:config_and_sel.config,
          \ 'tabWidth',
          \ g:prettier#config#tab_width)

  if (l:value ==# 'auto')
    let l:value = prettier#utils#shim#shiftwidth()
  endif

  return '--tab-width=' . l:value
endfunction

" Returns either '--use-tabs' or an empty string.
function! s:Flag_use_tabs(config_and_sel, ...) abort
  let l:value = get(
          \ a:config_and_sel.config,
          \ 'useTabs',
          \ g:prettier#config#use_tabs)

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
function! s:Flag_print_width(config_and_sel, ...) abort
  let l:value = get(
          \ a:config_and_sel.config,
          \ 'printWidth',
          \ g:prettier#config#print_width)

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
function! s:Flag_parser(config_and_sel, ...) abort
  let l:value = get(
          \ a:config_and_sel.config,
          \ 'parser',
          \ g:prettier#config#parser)

  if (l:value !=# '')
    return '--parser=' . l:value
  else
    return ''
  endif
endfunction

" Returns '--stdin-filepath=' concatenated with the full path of the opened
" file.
function! s:Flag_stdin_filepath(...) abort
  let l:current_file = simplify(expand('%:p'))
  return '--stdin-filepath="' . l:current_file . '"'
endfunction

" Returns '--loglevel error' or '--log-level error'.
function! s:Flag_loglevel(config_and_sel, flag, props) abort
  let l:level = 'error'
  return a:flag . ' ' . l:level
endfunction

" Returns '--stdin'.
function! s:Flag_stdin(...) abort
  return '--stdin '
endfunction

" Returns a flag name concantenated with its value in the JSON config object or
" in the default global Prettier config.
function! s:Concat_value_to_flag(config_and_sel, flag, props) abort
  let l:global_value = get(g:, 'prettier#config#' . a:props.global_name, "")

  let l:value = get(a:config_and_sel.config, a:props.json_name, l:global_value)

  return a:flag . '=' . l:value
endfunction

" Maps a flag name to a part of a command.
function! s:Map_flag_to_cmd_part(config_and_sel, flag, props) abort
  return a:props.mapper(a:config_and_sel, a:flag, a:props)
endfunction
let s:concat_value = function('s:Concat_value_to_flag')

let s:FLAGS = {
        \ '--use-tabs': {
        \   'json_name': 'useTabs',
        \   'global_name': 'use_tabs',
        \   'mapper': function('s:Flag_use_tabs')},
        \ '--tab-width': {
        \   'json_name': 'tabWidth',
        \   'global_name': 'tab_width',
        \   'mapper': function('s:Flag_tab_width')},
        \ '--print-width': {
        \   'json_name': 'printWidth',
        \   'global_name': 'print_width',
        \   'mapper': function('s:Flag_print_width')},
        \ '--parser': {
        \   'json_name': 'parser',
        \   'global_name': 'parser',
        \   'mapper': function('s:Flag_parser')},
        \ '--range-start': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_range_start')},
        \ '--range-end': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_range_end')},
        \ '--semi': {
        \   'json_name': 'semi',
        \   'global_name': 'semi',
        \   'mapper': s:concat_value},
        \ '--single-quote': {
        \   'json_name': 'singleQuote',
        \   'global_name': 'single_quote',
        \   'mapper': s:concat_value},
        \ '--bracket-spacing': {
        \   'json_name': 'bracketSpacing',
        \   'global_name': 'bracket_spacing',
        \   'mapper': s:concat_value},
        \ '--bracket-same-line': {
        \   'json_name': 'bracketSameLine',
        \   'global_name': 'bracket_same_line',
        \   'mapper': s:concat_value,
        \   'since': '2.4.0'},
        \ '--jsx-bracket-same-line': {
        \   'json_name': 'jsxBracketSameLine',
        \   'global_name': 'jsx_bracket_same_line',
        \   'mapper': s:concat_value,
        \   'deprecated': '2.4.0'},
        \ '--arrow-parens': {
        \   'json_name': 'arrowParens',
        \   'global_name': 'arrow_parens',
        \   'mapper': s:concat_value,
        \   'since': '1.9.0'},
        \ '--trailing-comma': {
        \   'json_name': 'trailingComma',
        \   'global_name': 'trailing_comma',
        \   'mapper': s:concat_value},
        \ '--config-precedence': {
        \   'json_name': 'configPrecedence',
        \   'global_name': 'config_precedence',
        \   'mapper': s:concat_value},
        \ '--prose-wrap': {
        \   'json_name': 'proseWrap',
        \   'global_name': 'prose_wrap',
        \   'mapper': s:concat_value,
        \   'since': '1.8.2'},
        \ '--html-whitespace-sensitivity': {
        \   'json_name': 'htmlWhitespaceSensitivity',
        \   'global_name': 'html_whitespace_sensitivity',
        \   'mapper': s:concat_value,
        \   'since': '1.15.0'},
        \ '--stdin-filepath': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_stdin_filepath')},
        \ '--require-pragma': {
        \   'json_name': 'requirePragma',
        \   'global_name': 'require_pragma',
        \   'mapper': s:concat_value,
        \   'since': '1.7.0'},
        \ '--end-of-line': {
        \   'json_name': 'endOfLine',
        \   'global_name': 'end_of_line',
        \   'mapper': s:concat_value,
        \   'since': '1.15.0'},
        \ '--loglevel': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_loglevel'),
        \   'deprecated': '3.0.0'},
        \ '--log-level': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_loglevel'),
        \   'since': '3.0.0'},
        \ '--stdin': {
        \   'json_name': '',
        \   'global_name': '',
        \   'mapper': function('s:Flag_stdin'),
        \   'deprecated': '2.0.0'}}

" Returns the argument string with unprintable characters represented in Vim
" internal format removed from both ends.
function! s:Trim_internal_unprintable(text) abort
  let l:char_patt = '\%(\%(\^\m.\)\|\%(<\x\x>\)\)\{}'
  let l:patt_at_ends = '^' . l:char_patt . '\|' . l:char_patt . '$'
  let l:trimmed_text = a:text->substitute(l:patt_at_ends, '', 'g')
  return l:trimmed_text
endfunction

" Returns the version of the Prettier CLI as a string.
function! s:Get_prettier_cli_version() abort
  let l:output = ''
  redir => l:output
    silent call prettier#PrettierCli('--version')
  redir END
  " The shell sends the string with whitespaces at both ends.
  let l:prettier_cli_version = s:Trim_internal_unprintable(trim(l:output))
  return l:prettier_cli_version
endfunction

" Returns 1 if the version of the flag argument is compatible with the
" version argument, otherwise returns 0.
function! s:Filter_uncompatible_flag(version, _, flag) abort
  let l:is_deprecated = exists('a:flag.deprecated')
          \ && prettier#utils#version#Is_greater_or_equal_version(
          \   a:version, a:flag.deprecated)
  if l:is_deprecated
    return 0
  endif

  let l:is_added = !exists('a:flag.since')
          \ || prettier#utils#version#Is_greater_or_equal_version(
          \   a:version, a:flag.since)
  if !l:is_added
    return 0
  endif
  return 1
endfunction
