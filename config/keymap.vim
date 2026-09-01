" ============================================================
" 快捷键配置 (vime keymap)
" 说明：少数映射会覆盖默认按键（如 q、<CR>、9、! 等），
"       不喜欢可注释掉对应行。
" ============================================================

" 窗口相关快捷键
noremap <c-h> <C-w>h
noremap <c-j> <C-w>j
noremap <c-k> <C-w>k
noremap <c-l> <C-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

if !common#functions#HasPlug('ResizeWindow.vim')
    " 更改窗口垂直大小
    nnoremap <M--> :resize +3<CR>
    nnoremap <M-_> :resize -3<CR>
    " 更改窗口水平大小
    nnoremap <M-(> :vertical resize -3<CR>
    nnoremap <M-)> :vertical resize +3<CR>
endif

" 分割窗口（方向化）
nnoremap <c-w>k :abo split <cr>
nnoremap <c-w>h :abo vsplit <cr>
nnoremap <c-w>j :rightbelow split <cr>
nnoremap <c-w>l :rightbelow vsplit <cr>

" 【可选】q 关闭窗口（覆盖默认 q 的宏录制，默认注释；喜欢 vime 风格再取消注释）
" nnoremap <silent> q <esc>:close<cr>
" vnoremap <silent> q <esc>:close<cr>

" 【可选】回车 / Shift+回车 折叠开关（覆盖默认 <CR> 换行，默认注释）
" nnoremap <CR> za
" nnoremap <S-Return> zMzo
" 关闭搜索颜色
nnoremap <BackSpace> :nohl<cr>

" 命令行移动
cnoremap <C-h> <Home>
cnoremap <C-l> <End>

" 使用 alt q 关闭当前buffer
nnoremap <M-q> <esc>:bdelete<cr>

" 【可选】去除 EX 模式；Q 用于录制宏（配合上方 q 关窗口，默认注释）
" nmap Q <nop>
" noremap Q q

" jk 表示 esc（插入模式）
inoremap jk <esc>

nmap << <<_
nmap >> >>_

" 按 ! 进入 shell 命令
nnoremap ! :!
" 【可选】9 到行尾（默认注释，保留默认计数用法）
" nnoremap 9 $

augroup vime_keymap_group
    autocmd!
    " 使用 esc 退出终端
    if has('nvim')
        au TermOpen term://* tnoremap <buffer> <Esc> <c-\><c-n>
    else
        au TerminalOpen term://* tnoremap <buffer> <Esc> <C-\><C-n>
    endif
augroup END

" 新建终端
nnoremap <leader>tt :terminal<cr>

" 插入模式下的快捷键
inoremap <M-o> <esc>o
inoremap <M-O> <esc>O
inoremap <M-h> <esc>^i
inoremap <M-l> <END>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

" 快速保存（space space 写当前文件）
noremap <silent> <space><space> <esc>:silent! write<cr>
xnoremap <silent> <space><space> <esc>:silent! write<cr>

" 可视行跳转
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 复制到末尾、整行选择
nnoremap Y y$
nnoremap vv ^vg_

if !common#functions#HasPlug('vim-airline') && !common#functions#HasPlug('vim-crystalline')
    nnoremap  <M-l> :call common#functions#MoveTabOrBuf(1)<cr>
    nnoremap  <M-h> :call common#functions#MoveTabOrBuf(0)<CR>
    tnoremap  <M-l> <c-\><c-n>:call common#functions#MoveTabOrBuf(1)<cr>
    tnoremap  <M-h> <c-\><c-n>:call common#functions#MoveTabOrBuf(0)<CR>
endif
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>tc :tabclose<cr>
nnoremap <silent> <M-L> :tabmove +1<cr>
nnoremap <silent> <M-H> :tabmove -1<cr>
tnoremap <silent> <M-L> <c-\><c-n>:tabmove +1<cr>
tnoremap <silent> <M-H> <c-\><c-n>:tabmove -1<cr>

" 使用系统应用打开当前buffer文件
noremap <silent> <M-x> :call common#functions#OpenFileUsingSystemApp(expand('%:p'))<cr>

" F5 编译运行 C/C++（保留原配置）
map <F5> :!clear && g++ % -o %< && ./%< <CR>
