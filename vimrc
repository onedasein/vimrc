set runtimepath+=~/.vim/autoload
"告知vim-plug使用SSH格式的URL
let g:plug_url_format = 'https://ghfast.top/https://github.com/%s.git'
" 指定插件开始的位置
call plug#begin()

    Plug 'yianwillis/vimcdoc'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'
    Plug 'lvht/tagbar-markdown'
    Plug 'ferrine/md-img-paste.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
    Plug 'preservim/nerdcommenter'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'tpope/vim-fugitive'
    Plug 'Yggdroot/indentLine'
    Plug 'frazrepo/vim-rainbow'
"    Plug 'itchyny/lightline.vim'
    Plug 'puremourning/vimspector'
call plug#end()

set nocompatible            "不用兼容老版本的 Vi
filetype plugin indent on   "打开文件类型依赖的插件和缩进

set history=1000            "在命令行里输入的命令保存在历史记录中的数量
set ruler                   "显示光标位置的行号和列号
set number                  "在每行之前显示行号
set showcmd                 "在屏幕最后一行显示命令
set showmode                 "在插入、替换和可视模式里，在最后一行提供消息
set laststatus=2            "最后一个窗口何时有状态行，2 为总是
set cmdheight=2             "命令行使用的屏幕行数
set scrolloff=3             "光标上下两侧最少保留的屏幕行数，这使得工作时总有一些可见的上下文
set sidescrolloff=2

"启用终端标题设置
"以下三行关闭响铃，也关闭闪烁
set noerrorbells
set novisualbell
set t_vb=

set termguicolors
colorscheme tokyonight          "主题
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 0

syntax on                   "打开语法高亮
set backspace=2             "允许在自动缩进、换行符、插入开始位置上退格
set whichwrap+=<,>,h,l      "使光标移动可以跨行

set expandtab               "插入 <Tab> 时，自动替换为合适数量的空格
set smarttab                "行首的 <Tab> 根据 'shiftwidth' 插入空白，<BS> 删除行首 'shiftwidth' 那么多的空白
set shiftwidth=4            "缩进每一步使用的空白数目
set tabstop=4               "文件里 <Tab> 代表的空格数
set autoindent              "自动缩进
set cindent                 "打开自动 C 程序缩进

set nobackup                "写入文件前不要备份
set noswapfile              "不要交换文件
set nowritebackup           "不用写入备份文件
set autoread                "如果文件在别处修改过，Vim 中重新自动读入
set autowrite               "切换缓冲区时，文件自动写入
set hidden                  "允许把未保存的缓冲区切换到后台
set fileencodings=utf-8,cp936
set fileformats=unix,dos,mac

"以下几行设置和字符串模式匹配有关的选项
set showmatch
set matchtime=2
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic
set lazyredraw
set nowrapscan
set iskeyword+=_,$,@,%,#,-,.

"以下几行设置补全的样式
set wildoptions=pum
set wildmode=full
set wildmenu
set completeopt=menu,menuone,noselect,noinsert

set previewpopup=height:20,width:80     "把预览窗口配置为弹出窗口

"按 F2 打开关闭文件树窗口
map <F2> :NERDTreeToggle<CR>          
"按 F3 打开函数列表窗口
map <F3> :TagbarToggle<CR>            
"按 F4 打开浮动的终端窗口
map <F4> :FloatermToggle<CR>          
"在打开终端窗口的情况下，按 F4 关闭浮动的终端窗口
tmap <F4> <C-\><C-n>:FloatermToggle<CR>  
"按 F5 自动编译运行 C/C++ 文件，错误信息会进入 QuickFix 窗口
map <F5> :!clear && g++ % -o %< && ./%< <CR>
let g:airline_powerline_fonts = 1
let airline#extensions#tabline#enable = 1

"下面几行配置为使用 gutentags 插件管理 ctags 文件
let g:gutentags_modules = ['ctags']
let g:gutentags_ctags_executable = '/usr/bin/ctags'
let g:gutentags_project_root = ['.git','.svn','.project','.root']
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags)
endif
let g:gutentags_ctags_extra_args = ['-e', '--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--kinds-C=+px']
let g:gutentags_ctags_extra_args += ['--kinds-C++=+px']

"下面几行配置为使用 LeaderF 插件管理 gtags 数据库
let g:Lf_RootMarkers = ['.git', '.svn', '.project', '.root']
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsAutoUpdate = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_WindowHeight = 0.3
let g:Lf_HideHelp = 1
let g:Lf_ShowRelativePath = 1

"以下内容为 indentLine 的配置
let g:indentLine_showFirstIndentLevel = 1

"以下内容开启 vim-rainbow
let g:rainbow_active=1

" 以下内容抄自 coc.nvim 的官网
set updatetime=300
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" diagnostics appear/become resolved

let g:mdip_imgdir = './images'
let g:mdip_imgname = 'image'
autocmd FileType markdown nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
" 启用lightline并设置主题
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['readonly', 'filename', 'modified'] ]
      \ },
      \ }
" 确保Vim原生状态栏被禁用（lightline会替代它）
set noshowmode
" 先允许Vim设置标题，然后自定义标题字符串
set title
set titlestring=lp_tower.vim
