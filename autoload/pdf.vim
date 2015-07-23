" =============================================================================
" Filename: autoload/pdf.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/06/13 20:43:00.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

try
  let s:words = filter(readfile(expand('<sfile>:p:h') . '/pdfwords'), 'v:val !=# ""')
catch
  let s:words = []
endtry

function! pdf#CompletePDF(findstart, base) abort
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~# '[-/%a-zA-Z0-9_]'
      let start -= 1
    endwhile
    return start
  else
    return filter(deepcopy(s:words), 'v:val =~# "^" . a:base')
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
