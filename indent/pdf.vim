" =============================================================================
" Language: pdf
" Filename: indent/pdf.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/06/02 00:01:39.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetPDFIndent()
setlocal indentkeys=*<CR>,o,O

if exists('*GetPDFIndent')
  finish
endif

function! GetPDFIndent()

  if prevnonblank(v:lnum - 1) == 0
    return 0
  endif

  let line = getline('.')

  let pairs = [ [ '<<', '>>' ], [ '\<BT\>', '\<ET\>' ] ]

  for pair in pairs
    if line =~# '^\s*' . pair[1]
      let i = line('.')
      let depth = 0
      while i
        let line = getline(i)
        if line =~# pair[1]
          let depth += 1
        endif
        if line =~# '^\s*' . pair[0]
          let depth -= 1
          if depth == 0
            break
          endif
        endif
        if line =~# '^\S'
          break
        endif
        let i -= 1
      endwhile
      if i > 0 && line =~# pair[0]
        return match(line, '^\s*\zs' . pair[0])
      endif
    endif
  endfor

  let line = getline(line('.') - 1)

  if line =~# '^\s*<<' && line !~# '>>'
    return match(line, '\s*<< *\zs')
  endif

  if line =~# '^\s*BT'
    return match(line, '\s*\zsBT') + &shiftwidth
  endif

  return indent(prevnonblank(v:lnum - 1))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
