let g:airline#themes#olanmatt#palette = {}

let g:airline#themes#olanmatt#palette.accents = {
      \ 'red': [ '#66d9ef' , '' , 81 , '' , '' ],
      \ }


" Normal mode
let s:N1 = [ '#1c1c1c' , '#e6db74' , 234 , 144 ] " mode
let s:N2 = [ '#d0d0d0' , '#1c1c1c' , 252 , 234  ] " info
let s:N3 = [ '#d0d0d0' , '#465457' , 252 , 67  ] " statusline

let g:airline#themes#olanmatt#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#olanmatt#palette.normal_modified = {
      \ 'airline_c': [ '#1c1c1c' , '#e6db74' , 234 , 144 , '' ] ,
      \ }


" Insert mode
let s:I1 = [ '#1c1c1c' , '#66d9ef' , 234 , 81 ]
let s:I2 = [ '#d0d0d0' , '#1c1c1c' , 252 , 234 ]
let s:I3 = [ '#d0d0d0' , '#465457' , 252 , 67 ]

let g:airline#themes#olanmatt#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#olanmatt#palette.insert_modified = {
      \ 'airline_c': [ '#1c1c1c' , '#66d9ef' , 234 , 81 , '' ] ,
      \ }


" Replace mode
let g:airline#themes#olanmatt#palette.replace = copy(g:airline#themes#olanmatt#palette.insert)
let g:airline#themes#olanmatt#palette.replace.airline_a = [ s:I1[0]   , '#ef5939' , s:I1[2] , 2346     , ''     ]
let g:airline#themes#olanmatt#palette.replace_modified = {
      \ 'airline_c': [ '#1c1c1c' , '#ef5939' , 234 , 2346 , '' ] ,
      \ }


" Visual mode
let s:V1 = [ '#1c1c1c' , '#fd971f' , 234 , 208 ]
let s:V2 = [ '#d0d0d0' , '#1c1c1c' , 252 , 234  ]
let s:V3 = [ '#d0d0d0' , '#465457' , 252 , 67  ]

let g:airline#themes#olanmatt#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#olanmatt#palette.visual_modified = {
      \ 'airline_c': [ '#1c1c1c' , '#fd971f' , 234 , 208 , '' ] ,
      \ }


" Inactive
let s:IA = [ '#1b1d1e' , '#465457' , 233 , 67 , '' ]
let g:airline#themes#olanmatt#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#olanmatt#palette.inactive_modified = {
      \ 'airline_c': [ '#d0d0d0' , ''        , 252 , ''  , '' ] ,
      \ }


" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#olanmatt#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#d0d0d0' , '#465457' , 252 , 67  , ''     ] ,
      \ [ '#d0d0d0' , '#1c1c1c' , 252 , 234  , ''     ] ,
      \ [ '#1c1c1c' , '#e6db74' , 234 , 144 , 'bold' ] )

