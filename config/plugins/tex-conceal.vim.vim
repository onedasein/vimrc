let g:tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts  = "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal_frac = 1

augroup vime_tex_conceal_group
    autocmd!
    autocmd FileType tex setl conceallevel=2
augroup END
