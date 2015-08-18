" =============================================================================
" Language: pdf
" Filename: indent/pdf.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/08/18 09:03:55.
" =============================================================================

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetPDFIndent()
setlocal indentkeys=*<CR>,o,O

let b:undo_indent = 'setlocal indentexpr< indentkeys<'

if exists('*GetPDFIndent')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

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
        if line =~# '^.*' . pair[0]
          let depth -= 1
          if depth == 0
            break
          endif
        endif
        " if line =~# '^\S'
        "   break
        " endif
        let i -= 1
      endwhile
      if i > 0 && line =~# pair[0]
        return indent(i)
      endif
    endif
  endfor

  let line = getline(prevnonblank(v:lnum - 1))

  if line =~# '<<' && line !~# '>>'
    return indent(prevnonblank(v:lnum - 1)) + &shiftwidth
  endif

  if line =~# '^\s\+>>$'
    let i = line('.') - 1
    let depth = 0
    while i
      let line = getline(i)
      if line =~# '>>'
        let depth += 1
      endif
      if line =~# '<<'
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
    if i > 0 && line =~# '>>\|<<'
      return indent(i)
    endif
  endif

  return indent(prevnonblank(v:lnum - 1))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
