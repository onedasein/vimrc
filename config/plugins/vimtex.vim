" vimtex 配置（参考 https://github.com/lervag/vimtex 与上游 vime）
" 教程：https://jdhao.github.io/2019/03/26/nvim_latex_write_preview/

let g:vimtex_cache_root = g:cache_root_path . '/vim/vimtex'
let g:tex_flavor = 'latex'

" 本机 Vim 9.1 / Neovim 0.9.5 低于 vimtex 最新版要求（Vim 9.2 / nvim 0.12.4），
" 关闭版本检查以在旧版本上使用（如遇兼容问题可改用更早的 vimtex 版本）
let g:vimtex_version_check = 0

if has("nvim")
    " 用于反向定位
    let g:vimtex_compiler_progname = 'nvr'
endif

" 默认 PDF 浏览器
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:tex_conceal = 'abdmg'

" latexmk 连续编译模式：:w 保存后自动更新 PDF（\ll 启动，\lk 停止）
" let g:vimtex_compiler_latexmk = {'continuous': 1}

" 目录（TOC）设置，\lt 打开
let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo', 'include'],
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \ 'split_width' : 50,
      \ 'split_pos' : 'vert botright',
      \}

" 自动打开 inkscape 绘图，然后插入到 latex 中
" 需要：inkscape + pip install inkscape-figures（已装）
if executable("inkscape")
    inoremap <C-i> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
endif

function! CloseViewers()
    " 关闭 buffer 时自动关闭浏览软件
    if executable('xdotool') && exists('b:vimtex')
        \ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
        silent call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
    endif
endfunction

augroup vime_vimtex_event_1
    autocmd!
    " 退出时清理编译产物并关闭预览
    au User VimtexEventQuit     call vimtex#compiler#clean(0)
    au User VimtexEventQuit     call CloseViewers()
augroup END
