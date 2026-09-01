" markdown-preview.nvim 配置（浏览器实时预览）
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_echo_preview_url = 1
let g:mkdp_theme = 'dark'
let g:mkdp_page_title = 'Markdown Preview'
let g:mkdp_filetypes = ['markdown']

" 快捷键：leader mp 打开/关闭预览
nnoremap <silent> <leader>mp :MarkdownPreviewToggle<CR>
