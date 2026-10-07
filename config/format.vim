" ============================================================
" 统一格式化入口 (vime format)
" 载入方式：vimrc 中 LoadScript base.vim 之后 LoadScript format.vim
" 调度函数：common#functions#FormatBuffer() (autoload/common/functions.vim)
" ============================================================

" filetype -> 外部格式化器命令模板
" 约定：从 stdin 读代码、向 stdout 输出结果（下面这些工具都满足）
" %s 会被替换为当前文件路径：用于语言判断、向上查找 .clang-format / .prettierrc
" 注：字典续行内不能写行尾 " 注释（Vimscript 会当成字符串起始，报 E114）
"     Python 未装 ruff 时，把下面的 'ruff format -' 换成 'black -q -' 即可
" 注：markdown 故意不进表 —— prettier 会重排段落/列表/表格，破坏 md 原有排版
"     （行尾两个空格的硬换行、表格对齐、列表标记与编号等），故不做自动处理。
"     确实需要时再手动跑 `prettier --write file.md`；想恢复自动格式化，把
"     'markdown' 同时加回本表与下面的 g:format_on_save_filetypes 即可。
let g:format_cmd_by_ft = {
    \ 'c':               'clang-format -assume-filename=%s',
    \ 'cpp':             'clang-format -assume-filename=%s',
    \ 'objc':            'clang-format -assume-filename=%s',
    \ 'cuda':            'clang-format -assume-filename=%s',
    \ 'python':          'ruff format -',
    \ 'javascript':      'prettier --stdin-filepath %s',
    \ 'typescript':      'prettier --stdin-filepath %s',
    \ 'javascriptreact': 'prettier --stdin-filepath %s',
    \ 'typescriptreact': 'prettier --stdin-filepath %s',
    \ 'json':            'prettier --stdin-filepath %s',
    \ 'jsonc':           'prettier --stdin-filepath %s',
    \ 'css':             'prettier --stdin-filepath %s',
    \ 'scss':            'prettier --stdin-filepath %s',
    \ 'html':            'prettier --stdin-filepath %s',
    \ 'yaml':            'prettier --stdin-filepath %s',
    \ 'sh':              'shfmt -',
    \ 'bash':            'shfmt -',
    \ 'lua':             'stylua -',
    \ 'tex':             'latexindent',
    \ }

" 手动格式化
command! -bar -nargs=0 Format call common#functions#FormatBuffer()
nnoremap <silent> <leader>f :<C-u>Format<CR>

" Vim 原生能力：C/C++ 下 = 与 gq 也走 clang-format（不依赖任何插件）
" 实测：equalprg 里的 % 会展开成当前文件完整路径，因此可以带 -assume-filename
autocmd FileType c,cpp,objc,cuda setlocal equalprg=clang-format\ -assume-filename=%

" 保存时自动格式化（默认开启；想关掉就 let g:format_on_save = 0）
" 触发方式：手动 :Format / <leader>f + 保存时自动（等价于 VS Code 的 formatOnSave）
let g:format_on_save = get(g:, 'format_on_save', 1)
let g:format_on_save_filetypes = get(g:, 'format_on_save_filetypes',
    \ ['c', 'cpp', 'objc', 'cuda', 'python', 'javascript', 'typescript',
    \  'json', 'jsonc', 'css', 'html', 'yaml', 'sh', 'lua'])

augroup vime_format_on_save
    autocmd!
    autocmd BufWritePre * if g:format_on_save && index(g:format_on_save_filetypes, &filetype) >= 0 | silent! Format | endif
augroup END
