" 主题与视觉配置
if &term =~ '256color' && $TMUX != ''
    set t_ut=
endif

if has('termguicolors')
    " fix bug for vim
    if !has('nvim')
        let &t_8f = "\e[38;2;%lu;%lu;%lum"
        let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
endif

" ------------------------------------------------------------
" 终端下的波浪线（undercurl）
" ------------------------------------------------------------
" 关键：Vim 的 undercurl 在终端里**默认不可用就静默降级成直线下划线**
" （:help underline-codes），因为 t_Cs（curly underline start）默认为空。
" 显式给出 SGR 4:3 / 4:0 才会真的画波浪线；t_Ce 同时也是各种下划线样式的结束码。
" 前提：外层终端要支持 SGR 4:3。Windows Terminal 支持；tmux 需要 usstyle 透传
" （:help terminal-features）。终端不支持时不会报错，只是退回直线下划线。
if !has('gui_running')
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
endif

" 高亮当前行
set cursorline
" 第 80 列竖线提示（代码风格用；不想要就保持注释）
" set colorcolumn=80
" 光标形状
set guicursor=n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20
" 搜索高亮
set incsearch
set hlsearch
" 显示特殊字符（tab/行尾/尾随空格）
set list
if &list
    set listchars=tab:\|\→·,nbsp:⣿,extends:»,precedes:«
    set listchars+=eol:¬
    set listchars+=trail:·
endif
" 搜索高亮颜色
hi Search ctermfg=17 ctermbg=190 guifg=#000000 guibg=#ffff00

" 弹出框大小/透明
set pumheight=20
if has('nvim')
    set pumblend=20
endif

" ============================================================
" 主题：当前使用 Edge（2026-01 版本）
" ============================================================

" ---- 原 TokyoNight（要换回就取消注释，并把下面 Edge 部分注释掉）----
" let g:tokyonight_style = 'night'
" let g:tokyonight_enable_italic = 1
" let g:tokyonight_transparent_background = 1
" silent! colorscheme tokyonight

" ---- Edge（对比 TokyoNight 的配置写法）----
let g:edge_style = 'default'              " 对应 tokyonight 的 night（另有 aura/neon 等风格可试）
let g:edge_enable_italic = 1              " 对应 tokyonight_enable_italic = 1
let g:edge_transparent_background = 1     " 对应 tokyonight_transparent_background = 1
silent! colorscheme edge
