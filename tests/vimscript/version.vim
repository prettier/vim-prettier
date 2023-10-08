" To run the tests in this script, first add the vim-prettier plugin and let
" Vim load it, then uncomment the last line in this script, and source this
" file in Vim with the command
" ":source <file-path>" where <file-path> is the path to this file, e.g.
" ":source %".

function! s:Test_version_comparison_greater_case() abort
  echomsg 'Testing version comparison, greater case.'

  let l:ver_1 = '2.7.3'
  let l:ver_2 = '0.9.8'
  let l:value = prettier#utils#version#Compare_versions(l:ver_1, l:ver_2)
  let l:expected = 1
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Test_version_comparison_lesser_case() abort
  echomsg 'Testing version comparison, lesser case.'

  let l:ver_1 = '3.9.5'
  let l:ver_2 = '10.5.2'
  let l:value = prettier#utils#version#Compare_versions(l:ver_1, l:ver_2)
  let l:expected = -1
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Test_version_comparison_equal_case() abort
  echomsg 'Testing version comparison, equal case.'

  let l:ver_1 = '8.2.4'
  let l:ver_2 = '8.2.4'
  let l:value = prettier#utils#version#Compare_versions(l:ver_1, l:ver_2)
  let l:expected = 0
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Test_is_greater_or_equal_version_greater_case() abort
  echomsg 'Testing function that checks if is lesser version, greater case.'

  let l:ver_1 = '3.8.1'
  let l:ver_2 = '0.2.9'
  let l:value = prettier#utils#version#Is_greater_or_equal_version(
          \ l:ver_1, l:ver_2)
  let l:expected = 1
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Test_is_greater_or_equal_version_lesser_case() abort
  echomsg 'Testing function that checks if is lesser version, lesser case.'

  let l:ver_1 = '7.2.8'
  let l:ver_2 = '15.1.6'
  let l:value = prettier#utils#version#Is_greater_or_equal_version(
          \ l:ver_1, l:ver_2)
  let l:expected = 0
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Test_is_greater_or_equal_version_equal_case() abort
  echomsg 'Testing function that checks if is lesser version, lesser case.'

  let l:ver_1 = '4.12.185'
  let l:ver_2 = '4.12.185'
  let l:value = prettier#utils#version#Is_greater_or_equal_version(
          \ l:ver_1, l:ver_2)
  let l:expected = 1
  return assert_equal(
          \ l:value,
          \ l:expected,
          \ 'Expected ' . l:expected . ' but received ' . l:value
          \ . ' instead.')
endfunction

function! s:Run_tests() abort
  let v:errors = []

  let l:test_functions = [
          \ function('s:Test_version_comparison_greater_case'),
          \ function('s:Test_version_comparison_lesser_case'),
          \ function('s:Test_version_comparison_equal_case'),
          \ function('s:Test_is_greater_or_equal_version_greater_case'),
          \ function('s:Test_is_greater_or_equal_version_lesser_case'),
          \ function('s:Test_is_greater_or_equal_version_equal_case')]

  let l:results_as_returned = l:test_functions->copy()->map('v:val()')
  let l:results_as_text = l:results_as_returned
          \ ->copy()
          \ ->map('v:key + 1 .. '': '' .. (v:val ? "failed" : "passed")')

  let l:has_failed_test = v:errors->len() > 0
          \ || l:results_as_returned->index(1) >= 0
  if l:has_failed_test
    echoerr 'The tests failed.'
    echoerr 'Results:'
    echoerr l:results_as_text->join('; ')
    echoerr 'Errors:'
    echoerr v:errors->join('; ')
  else
    echomsg 'The tests were completed successfully.'
    echomsg 'Results:'
    echomsg l:results_as_text->join('; ')
  endif
endfunction

" Uncomment the next line to run the tests.
" call s:Run_tests()
