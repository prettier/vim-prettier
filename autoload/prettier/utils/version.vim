" Returns 1 if the first argument is the greater version, returns 0 if the
" arguments are the same version, or returns -1 if the first argument is the
" lesser version.
function! prettier#utils#version#Compare_versions(a, b) abort
  let [l:a_major, l:a_minor, l:a_patch; l:rest] = a:a->split('\D')
          \ ->map('str2nr(v:val)')
  let [l:b_major, l:b_minor, l:b_patch; l:rest] = a:b->split('\D')
          \ ->map('str2nr(v:val)')
  let l:is_a_greater =
          \ l:a_major > l:b_major
          \ || (l:a_major == l:b_major && l:a_minor > l:b_minor)
          \ || (l:a_major == l:b_major && l:a_minor == l:b_minor
          \   && l:a_patch > l:b_patch)
  let l:is_a_equal_b =
          \ l:a_major == l:b_major
          \ && l:a_minor == l:b_minor
          \ && l:a_patch == l:b_patch
  return l:is_a_greater ? 1 : (l:is_a_equal_b ? 0 : -1)
endfunction

" Returns 1 if the first argument is greater than or equal to the second,
" otherwise returns 0.
function! prettier#utils#version#Is_greater_or_equal_version(a, b) abort
  return prettier#utils#version#Compare_versions(a:a, a:b) != -1
endfunction
