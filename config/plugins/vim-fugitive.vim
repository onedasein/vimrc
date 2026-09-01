" vim-fugitive 快捷键
nnoremap <leader>gw <esc>:Gwrite<cr>
nnoremap <leader>gc <esc>:Git commit<cr>
nnoremap <leader>gr <esc>:Gread<cr>
nnoremap <leader>gl <esc>:Git log<cr>
nnoremap <leader>gg <esc>:Git<cr>

if !common#functions#HasPlug('vgit.nvim')
    nnoremap <leader>gd <esc>:Gvdiffsplit<cr>
    nnoremap <leader>gb <esc>:Git blame<cr>
endif
