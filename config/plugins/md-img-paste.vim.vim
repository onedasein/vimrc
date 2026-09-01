" md-img-paste.vim：粘贴剪贴板图片到 markdown
let g:mdip_imgdir = './images'
let g:mdip_imgname = 'image'
autocmd FileType markdown nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
