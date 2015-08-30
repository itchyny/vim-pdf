highlight link pdfStream Comment

syntax match String '(.*)' contained containedin=pdfStream
syntax match pdfDelimiter '[()]' contained containedin=String
