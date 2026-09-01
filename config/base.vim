" 基本配置 (vime base, 含持久撤销/剪贴板/相对行号等增强)
if &compatible
    set nocompatible
endif

if has('syntax')
    syntax enable
    syntax on
endif

if has('autocmd')
    filetype plugin indent on
endif

if has('multi_byte')
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
endif

set number
" 相对行号（配合 number 显示绝对+相对）
set relativenumber
" 智能缩进
set smartindent
set autoindent
" 软折行
set linebreak
" 禁止生成swap文件
set noswapfile
" 修复 WSL/Windows Terminal 下 F1-F4 功能键错乱：
" 本机 vim 的 terminfo 把 F1-F4 记为 ESC[11;*~ 形式，而 Windows Terminal
" 实际发送 ESC O P/Q/R/S（SS3），导致按 F1-F4 变成 P/Q/R/S（粘贴/Ex/Replace/S 插入）
if !has('nvim')
    let &t_k1 = "\<Esc>OP"
    let &t_k2 = "\<Esc>OQ"
    let &t_k3 = "\<Esc>OR"
    let &t_k4 = "\<Esc>OS"
endif

" 隐藏缓冲区，切来切去不丢
set hidden
" 忽略大小写 + 智能大小写
set ignorecase
set smartcase
set infercase
" 历史命令
set history=500
" 在下方分割
set splitbelow
" tab 扩展为空格
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set shiftround

if has('folding')
    set foldenable
    set foldmethod=syntax
    set foldlevel=99
endif

set nobackup
set nowritebackup
set shortmess+=c
set sessionoptions+=globals
" 文件在外部被修改时重新读入
set autoread
" 自动写回
set autowrite
" 显示确认对话框
set confirm
" 不显示模式提示（airline/状态栏会显示）
set noshowmode
set ttimeout
set timeoutlen=500
" ttimeoutlen 调大（10->50），避免终端功能键转义序列被拆散（F1-F4 错乱问题）
set ttimeoutlen=50
" 更新时间100ms
set updatetime=100
" 允许鼠标（normal 生效）
set mouse=n
set winaltkeys=no
" 延迟绘制，提升性能
set lazyredraw

set showmatch
set matchtime=2
set ffs=unix,dos,mac
" 与系统共用剪切板
set clipboard+=unnamedplus

if has('nvim') == 0 && has('patch-8.1.2020')
    set cursorlineopt=number cursorline
endif

if has('patch-8.1.1564')
    set signcolumn=yes
else
    set signcolumn=yes
endif

" 持久撤销（即使没有 undo 插件也能跨会话撤销）
if has('persistent_undo')
    set undofile
    if !isdirectory(g:undo_dir)
        call mkdir(g:undo_dir, 'p')
    endif
    exec 'set undodir=' . fnameescape(g:undo_dir)
endif

" 定位到退出时的位置并移动到屏幕中央
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
endif

" 文件搜索和补全时忽略的扩展名
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
