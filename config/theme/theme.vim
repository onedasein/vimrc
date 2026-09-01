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

" TokyoNight 主题
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
silent! colorscheme tokyonight
