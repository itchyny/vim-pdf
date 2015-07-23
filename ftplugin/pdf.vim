" =============================================================================
" Filename: ftplugin/pdf.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/06/14 01:39:10.
" =============================================================================

if exists('b:did_ftplugin')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

setlocal omnifunc=pdf#CompletePDF

setlocal iskeyword+=/

let b:undo_ftplugin = 'setlocal omnifunc<'

let &cpo = s:save_cpo
unlet s:save_cpo
